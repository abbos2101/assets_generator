import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:res_generator_annotation/res_generator_annotation.dart';

part 'custom_icons.g.dart';

@ResImagesAnnotation(
  className: 'CustomIcons',
  assetsDirectory: 'assets/icons/',
  isSvg: true,
)
extension on String {}
