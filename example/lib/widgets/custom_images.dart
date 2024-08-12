import 'package:flutter/material.dart';
import 'package:assets_annotations/annotations.dart';

part 'custom_images.g.dart';

@AssetsImagesAnnotation(
  assetsDirectory: 'assets/images/',
  suffix: 'Gen',
  isSvg: false,
)
abstract class CustomImages {
  const CustomImages._();
}
