import 'package:flutter/material.dart';
import 'package:res_generator_annotation/res_generator_annotation.dart';

part 'custom_images.g.dart';

@ResImagesAnnotation(
  className: 'CustomImages',
  assetsDirectory: 'assets/images/',
  isSvg: false,
)
extension on String {}
