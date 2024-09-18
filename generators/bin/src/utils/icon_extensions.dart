import 'dart:io';
import 'string_variable_extensions.dart';

String stringPart({
  required String classFileName,
  required String className,
}) {
  var string = """
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

part '$classFileName.res.dart';

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
              SvgPicture.asset($className.list[i], height: 100),
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
  buffer.writeln("// ResIconsGenerator");
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
      "  static final $variableName = SvgPicture.asset('${file.path}');",
    );
    stringFiles.add("'${file.path}'");
  }
  buffer.writeln();
  buffer.writeln("  static const list = <String>$stringFiles;");
  buffer.writeln('}');
  buffer.writeln();
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
  
  String get path => (this.bytesLoader as SvgAssetLoader).assetName;
}
""");
  return buffer.toString();
}
