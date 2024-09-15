import 'dart:convert';
import 'dart:io';
import 'string_variable_extensions.dart';

bool isCheckSafe({
  required String assetsDirectory,
  required List<String> supportedLocales,
}) {
  for (int i = 0; i < supportedLocales.length; i++) {
    if (!File('$assetsDirectory${supportedLocales[i]}.json').existsSync()) {
      print('File $assetsDirectory${supportedLocales[i]}.json does not exist.');
      return false;
    }
  }
  return true;
}

String stringPart({
  required String classFileName,
  required String className,
}) {
  return """
import 'package:easy_localization/easy_localization.dart';

part '$classFileName.g.dart';

/// You can change code and method names
/// use any package for example easy_localization
/// use $className.hello.str() or str($className.hello)
extension MyString on String {
  String str() => this.tr();
}

String str(String key) => key.tr();
""";
}

String stringPartOf({
  required String assetsDirectory,
  required String classFileName,
  required String className,
  required String targetLocale,
}) {
  final str = File('$assetsDirectory$targetLocale.json').readAsStringSync();
  final json = jsonDecode(str);
  return """
// GENERATED CODE - DO NOT MODIFY BY HAND

part of '$classFileName.dart';

// **************************************************
// ResIconsGenerator
// **************************************************

abstract class $className {
  const $className._();

  ${json.keys.map((e) => "static const String ${'$e'.toCamelCase()} = '$e';").join('\n  ')}
}
""";
}
