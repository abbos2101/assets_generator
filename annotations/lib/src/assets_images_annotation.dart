class AssetsImagesAnnotation {
  final String assetsDirectory;
  final String prefix;
  final String suffix;
  final bool isSvg;

  /// need import 'package:flutter/material.dart';
  /// need import 'package:flutter_svg/flutter_svg.dart';
  /// for `SVG` | `JPG | PNG | GIF | JPEG` files
  const AssetsImagesAnnotation({
    /// example: assets/images/
    required this.assetsDirectory,

    /// example: Assets
    this.prefix = '',

    /// example: Assets
    this.suffix = 'Generators',

    /// example: true(svg) or false(image)
    required this.isSvg,
  });
}
