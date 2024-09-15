import 'dart:io';
import "package:yaml/yaml.dart";
import 'src/icon_helper.dart';
import 'src/image_helper.dart';
import 'src/word_helper.dart';

void main() {
  final json = loadYaml(File('res_generator.yaml').readAsStringSync());
  ImageHelper.fromJson(json['images']).generate();
  IconHelper.fromJson(json['icons']).generate();
  WordHelper.fromJson(json['words']).generate();
  print('');
  print('-= Finished =-');
}
