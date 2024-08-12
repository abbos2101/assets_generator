library generators;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'src/assets_images_generator.dart';
import 'src/assets_locales_generator.dart';

Builder generateJsonMethods(BuilderOptions options) {
  return SharedPartBuilder(
    [
      AssetsImagesGenerator(),
      AssetsLocalesGenerator(),
    ],
    'assets_generator',
  );
}
