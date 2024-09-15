import 'dart:io';
import 'string_variable_extensions.dart';

String stringPart({
  required String classFileName,
  required String className,
}) {
  var string = """
import 'package:flutter/material.dart';

part '$classFileName.g.dart';

/// To view images, to be easy to search
/// You can add any changes
void main() {
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("$className: \${${className}.list.length}")),
        body: ListView.separated(
          itemCount: $className.list.length,
          separatorBuilder: (_, i) => const Divider(height: 12),
          itemBuilder: (_, i) => Column(
            children: [
              Image.asset(
                $className.list[i],
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              Text($className.list[i], style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
""";
  return string;
}

String stringPartOf({
  required Directory assetsDirectory,
  required String classFileName,
  required String className,
}) {
  final buffer = StringBuffer();
  buffer.writeln("// GENERATED CODE - DO NOT MODIFY BY HAND");
  buffer.writeln();
  buffer.writeln("part of '$classFileName.dart';");
  buffer.writeln();
  buffer.writeln("// **************************************************");
  buffer.writeln("// ResImagesGenerator");
  buffer.writeln("// **************************************************");
  buffer.writeln();
  buffer.writeln('abstract class $className {');
  buffer.writeln('  const $className._();');
  buffer.writeln();

  final files = assetsDirectory.listSync().whereType<File>();
  final stringFiles = <String>[];
  for (var file in files) {
    final fileName = file.uri.pathSegments.last;
    final variableName =
        fileName.substring(0, fileName.indexOf('.')).toCamelCase();
    buffer.writeln(
      "  static final $variableName = Image.asset('${file.path}');",
    );
    stringFiles.add("'${file.path}'");
  }
  buffer.writeln();
  buffer.writeln("  static const list = <String>$stringFiles;");
  buffer.writeln('}');
  buffer.writeln();
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
