import 'dart:convert';
import 'dart:io';
import 'utils/word_extensions.dart';
import 'utils/string_variable_extensions.dart';

class WordHelper {
  final String assetsDirectory;
  final String classDirectory;
  final String classFile;
  final String className;
  final List<String> supportedLocales;
  final String targetLocale;

  const WordHelper._({
    this.assetsDirectory = '',
    this.classDirectory = '',
    this.classFile = '',
    this.className = '',
    this.supportedLocales = const [],
    this.targetLocale = '',
  });

  factory WordHelper.fromJson(dynamic json) {
    if (json == null) return WordHelper._();
    return WordHelper._(
      assetsDirectory: json['assets_directory'] ?? '',
      classDirectory: json['class_directory'] ?? '',
      classFile: json['class_file'] ?? '',
      className: json['class_name'] ?? '',
      supportedLocales:
          ((json['supported_locales'] ?? []) as List).map((e) => '$e').toList(),
      targetLocale: json['target_locale'] ?? '',
    );
  }

  void generate() {
    if (assetsDirectory.isNotEmpty &&
        classDirectory.isNotEmpty &&
        classFile.isNotEmpty &&
        classFile.lastIndexOf('.dart') != -1 &&
        className.isNotEmpty &&
        supportedLocales.isNotEmpty &&
        targetLocale.isNotEmpty) {
      final assetsDir = Directory(assetsDirectory);
      if (!assetsDir.existsSync()) {
        print('Error: Assets directory $assetsDir does not exist.');
        return;
      }

      final classDir = Directory(classDirectory);
      if (!classDir.existsSync()) {
        classDir.createSync(recursive: true);
        print('Class directory $classDir does not exist.');
      }
      if (isCheckSafe(
        assetsDirectory: assetsDirectory,
        supportedLocales: supportedLocales,
      )) {
        _writePartAndParOf();
        _writeLocales();
        print('Success!!!');
      }
    }
  }

  void _writePartAndParOf() {
    final strPart = stringPart(
      classFileName: classFile.name,
      className: className,
    );
    final strPartOf = stringPartOf(
      assetsDirectory: assetsDirectory,
      classFileName: classFile.name,
      className: className,
      targetLocale: targetLocale,
    );

    final filePart = File('$classDirectory${classFile.name}.dart');
    final filePartOf = File('$classDirectory${classFile.name}.g.dart');

    if (!filePart.existsSync()) {
      filePart.writeAsStringSync(strPart);
      print('${className.name}.dart has been created.');
    }

    if (filePartOf.existsSync()) {
      if (filePartOf.readAsStringSync().removeExtraSpaces() !=
          strPartOf.removeExtraSpaces()) {
        filePartOf.writeAsStringSync(strPartOf);
        print('${className.name}.g.dart has been updated.');
      }
    } else {
      filePartOf.writeAsStringSync(strPartOf);
      print('${className.name}.g.dart has been created.');
    }
  }

  void _writeLocales() {
    final targetFile = File('$assetsDirectory$targetLocale.json');
    final targetString = targetFile.readAsStringSync();
    final keys = (jsonDecode(targetString) as Map).keys.toList();
    keys.sort();
    for (int i = 0; i < supportedLocales.length; i++) {
      final file = File('$assetsDirectory${supportedLocales[i]}.json');
      final string = file.readAsStringSync();
      final json = jsonDecode(string);
      final map = <String, String>{};
      keys.forEach((e) => map[e] = json[e] ?? '');

      final output = JsonEncoder.withIndent('  ').convert(map);
      if (string.removeExtraSpaces() != output.removeExtraSpaces()) {
        file.writeAsStringSync(output);
      }
    }
  }
}
