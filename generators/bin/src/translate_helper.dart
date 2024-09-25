import 'dart:convert';
import 'dart:io';
import 'package:translator/translator.dart';

import 'utils/word_extensions.dart';
import 'utils/string_variable_extensions.dart';

class TranslateHelper {
  final String assetsDirectory;
  final List<String> supportedLocales;
  final String targetLocale;

  const TranslateHelper._({
    this.assetsDirectory = '',
    this.supportedLocales = const [],
    this.targetLocale = '',
  });

  factory TranslateHelper.fromJson(dynamic json) {
    if (json == null) return TranslateHelper._();
    return TranslateHelper._(
      assetsDirectory: json['assets_directory'] ?? '',
      supportedLocales:
          ((json['supported_locales'] ?? []) as List).map((e) => '$e').toList(),
      targetLocale: json['target_locale'] ?? '',
    );
  }

  Future<void> generate() async {
    if (assetsDirectory.isNotEmpty &&
        supportedLocales.isNotEmpty &&
        targetLocale.isNotEmpty) {
      final assetsDir = Directory(assetsDirectory);
      if (!assetsDir.existsSync()) {
        print('Error: Assets directory $assetsDir does not exist.');
        return;
      }

      if (isCheckSafe(
        assetsDirectory: assetsDirectory,
        supportedLocales: supportedLocales,
      )) {
        print('Start');
        await _writeLocales();
        print('Translate success!!!');
      }
    }
  }

  Future<void> _writeLocales() async {
    final translator = GoogleTranslator();
    final targetFile = File('$assetsDirectory$targetLocale.json');
    final targetString = targetFile.readAsStringSync();
    final targetJson = jsonDecode(targetString) as Map;
    final keys = targetJson.keys.toList();
    keys.sort();
    for (int i = 0; i < supportedLocales.length; i++) {
      final file = File('$assetsDirectory${supportedLocales[i]}.json');
      final string = file.readAsStringSync();
      final json = jsonDecode(string);
      final map = <String, String>{};
      for (int j = 0; j < keys.length; j++) {
        final key = keys[j];
        final String value = json[key] ?? '';
        if (value.isEmpty) {
          final translated = await translator.translate(
            targetJson[key] ?? '',
            from: targetLocale,
            to: supportedLocales[i],
          );
          map[key] = translated.text;
        } else {
          map[key] = value;
        }
      }
      final output = JsonEncoder.withIndent('  ').convert(map);
      if (string.removeExtraSpaces() != output.removeExtraSpaces()) {
        file.writeAsStringSync(output);
      }
    }
  }
}
