import 'dart:convert';
import 'dart:io';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'utils/model_visitor.dart';
import 'utils/string_variable_extensions.dart';

class AssetsLocalesGenerator
    extends GeneratorForAnnotation<AssetsLocalesAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    final className = visitor.className;
    final supportLocales = annotation
        .read('supportedLocales')
        .listValue
        .map(
          (e) => "$e"
              .replaceAll("String", "")
              .replaceAll("(", "")
              .replaceAll(")", "")
              .replaceAll("'", "")
              .trim(),
        )
        .toList();
    final targetLocale = annotation.read('targetLocale').stringValue;
    final prefix = annotation.read('prefix').stringValue;

    final directoryPath = annotation.read('assetsDirectory').stringValue;
    if (!Directory(directoryPath).existsSync()) {
      log.warning('Directory $directoryPath does not exist.');
      return '';
    }
    if (!isCheckSafe(
      directoryPath: directoryPath,
      targetLocale: targetLocale,
      supportLocales: supportLocales,
    )) {
      log.warning('Some files in $directoryPath are missing.');
      return '';
    }
    setLocaleJson(
      directoryPath: directoryPath,
      targetLocale: targetLocale,
      supportLocales: supportLocales,
    );

    final buffer = StringBuffer();
    buffer.writeln(generateWords(
      className: className,
      prefix: prefix,
      directoryPath: directoryPath,
      targetLocale: targetLocale,
    ));
    return buffer.toString();
  }

  bool isCheckSafe({
    required String directoryPath,
    required String targetLocale,
    required List<String> supportLocales,
  }) {
    for (int i = 0; i < supportLocales.length; i++) {
      if (!File('$directoryPath/${supportLocales[i]}.json').existsSync()) {
        log.warning(
          'File $directoryPath/${supportLocales[i]}.json does not exist.',
        );
        return false;
      }
    }
    return true;
  }

  void setLocaleJson({
    required String directoryPath,
    required String targetLocale,
    required List<String> supportLocales,
  }) {
    final file = File('$directoryPath/$targetLocale.json');
    final string = file.readAsStringSync();
    final Map<String, dynamic> targetMap = jsonDecode(string);
    final Map<String, dynamic> empty = {};
    final keys = targetMap.keys.toList();
    keys.sort();
    for (var e in keys) {
      empty[e] = targetMap[e];
    }
    targetMap.clear();
    targetMap.addAll(empty);
    file.writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(targetMap),
    );

    for (int i = 0; i < supportLocales.length; i++) {
      final sourceFile = File('$directoryPath/${supportLocales[i]}.json');
      final sourceString = sourceFile.readAsStringSync();
      final Map<String, dynamic> sourceMap = jsonDecode(sourceString);
      if (supportLocales[i] != targetLocale) {
        final Map<String, dynamic> empty = {};
        final keys = targetMap.keys.toList();
        for (var e in keys) {
          empty[e] = sourceMap[e] ?? '';
        }
        sourceFile.writeAsStringSync(
          const JsonEncoder.withIndent('  ').convert(empty),
        );
      }
    }
  }

  String generateWords({
    required String className,
    required String prefix,
    required String directoryPath,
    required String targetLocale,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('abstract class $prefix$className {');
    buffer.writeln('const $prefix$className._();');
    buffer.writeln();

    final file = File('$directoryPath/$targetLocale.json');
    final string = file.readAsStringSync();
    final Map<String, dynamic> targetMap = jsonDecode(string);
    for (var e in targetMap.keys) {
      buffer.writeln("static const String ${e.toCamelCase()} = '$e';");
    }
    buffer.writeln('}');
    return buffer.toString();
  }
}
