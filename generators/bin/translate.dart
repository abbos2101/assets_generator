import 'dart:io';
import "package:yaml/yaml.dart";
import 'src/word_helper.dart';
import 'src/translate_helper.dart';

void main() async {
  WordHelper.fromJson(_getJsonWords()).generate();
  await TranslateHelper.fromJson(_getJsonWords()).generate();
  print('');
  print('-= Finished =-');
}

dynamic _getJsonWords() {
  final string = File('res_generator.yaml').readAsStringSync();
  final json = loadYaml(string);
  return json['words'];
}
