library res_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'src/res_images_generator.dart';
import 'src/res_words_generator.dart';

Builder generateJsonMethods(BuilderOptions options) {
  return SharedPartBuilder(
    [
      ResImagesGenerator(),
      ResWordsGenerator(),
    ],
    'res_generator',
  );
}
