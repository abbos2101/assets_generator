import 'dart:io';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:res_generator_annotation/res_generator_annotation.dart';
import 'utils/model_visitor.dart';
import 'utils/string_variable_extensions.dart';

class ResImagesGenerator extends GeneratorForAnnotation<ResImagesAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    final className = annotation.read('className').stringValue;
    final isSvg = annotation.read('isSvg').boolValue;

    // Use Directory instead of File
    final directoryPath = annotation.read('assetsDirectory').stringValue;
    final directory = Directory(directoryPath);

    if (!directory.existsSync()) {
      log.warning('Directory $directoryPath does not exist.');
      return '';
    }

    final buffer = StringBuffer();
    buffer.writeln(generateClass(
      className: className,
      directory: directory,
      isSvg: isSvg,
    ));
    buffer.writeln();
    buffer.writeln(generateExtensions(className: className, isSvg: isSvg));

    return buffer.toString();
  }

  String generateClass({
    required String className,
    required Directory directory,
    required bool isSvg,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('abstract class $className {');
    buffer.writeln('const $className._();');
    buffer.writeln();

    final files = directory.listSync().whereType<File>();
    for (var file in files) {
      final fileName = file.uri.pathSegments.last;
      final variableName =
          fileName.substring(0, fileName.indexOf('.')).toCamelCase();
      buffer.writeln(
        "static final $variableName = "
        "${isSvg ? "SvgPicture" : "Image"}.asset('${file.path}');",
      );
    }

    buffer.writeln('}');
    return buffer.toString();
  }
}

String generateExtensions({
  required String className,
  required bool isSvg,
}) {
  final buffer = StringBuffer();
  if (isSvg) {
    buffer.writeln("""
extension Extension$className on SvgPicture {
  SvgPicture copyWith({
    double? width,
    double? height,
    BoxFit? fit,
    ColorFilter? colorFilter,
  }) {
    return SvgPicture.asset(
      path,
      width: width ?? this.width,
      height: height ?? this.height,
      fit: fit ?? this.fit,
      colorFilter: colorFilter ?? this.colorFilter,
    );
  }
  
  String get path => "\$bytesLoader".substring(15, "\$bytesLoader".length - 1);
}
""");
    return buffer.toString();
  }

  buffer.writeln("""
extension Extension$className on Image {
  Image copyWith({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return Image(
      image: image,
      width: width ?? this.width,
      height: height ?? this.height,
      fit: fit ?? this.fit,
      color: color ?? this.color,
    );
  }

  String get path {
    final path = "\$image";
    const key = ', name: "';
    if (path.contains(key)) {
      return path.substring(path.indexOf(key) + key.length, path.length - 2);
    }
    return "";
  }
}
""");
  return buffer.toString();
}
