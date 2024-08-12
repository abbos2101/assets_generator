import 'package:annotations/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'custom_icons.g.dart';

@AssetsImagesAnnotation(
  assetsDirectory: 'assets/icons/',
  suffix: 'Gen',
  isSvg: true,
)
abstract class CustomIcons {
  const CustomIcons._();
}
