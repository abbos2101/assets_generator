import 'dart:io';
import "package:yaml/yaml.dart";
import 'src/icon_helper.dart';
import 'src/image_helper.dart';
import 'src/word_helper.dart';

void main() {
  final string = File('res_generator.yaml').readAsStringSync();
  final json = loadYaml(string);
  ImageHelper.fromJson(json['images']).generate();
  IconHelper.fromJson(json['icons']).generate();
  WordHelper.fromJson(json['words']).generate();
  print('');
  print('-= Finished =-');
}
