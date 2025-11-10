import 'dart:convert';
import 'dart:io';

import 'package:translator/translator.dart';

import 'utils/string_variable_extensions.dart';
import 'utils/word_extensions.dart';

class TranslateHelper {
  final String assetsDirectory;
  final List<String> translatedLocales;
  final String targetLocale;

  const TranslateHelper._({
    this.assetsDirectory = '',
    this.translatedLocales = const [],
    this.targetLocale = '',
  });

  factory TranslateHelper.fromJson(dynamic json) {
    if (json == null) return TranslateHelper._();
    return TranslateHelper._(
      assetsDirectory: json['assets_directory'] ?? '',
      translatedLocales: ((json['translated_locales'] ?? []) as List)
          .map((e) => '$e')
          .toList(),
      targetLocale: json['target_locale'] ?? '',
    );
  }

  Future<void> generate() async {
    if (assetsDirectory.isNotEmpty &&
        translatedLocales.isNotEmpty &&
        targetLocale.isNotEmpty) {
      final assetsDir = Directory(assetsDirectory);
      if (!assetsDir.existsSync()) {
        print('Error: Assets directory $assetsDir does not exist.');
        return;
      }

      if (isCheckSafe(
        assetsDirectory: assetsDirectory,
        locales: translatedLocales,
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
    for (int i = 0; i < translatedLocales.length; i++) {
      final file = File('$assetsDirectory${translatedLocales[i]}.json');
      final string = file.readAsStringSync();
      final json = jsonDecode(string);
      final map = <String, String>{};
      for (int j = 0; j < keys.length; j++) {
        final key = keys[j];
        final String value = json[key] ?? '';
        if (value.isEmpty) {
          final translated = await translator.translate(
            targetJson[key] ?? '',
            from: targetLocale.toLang(),
            to: translatedLocales[i].toLang(),
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

extension on String {
  String toLang() => split('-').first.toLowerCase();
}