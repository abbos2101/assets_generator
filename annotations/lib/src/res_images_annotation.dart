class ResImagesAnnotation {
  final String className;
  final String assetsDirectory;
  final bool isSvg;

  /// need import 'package:flutter/material.dart';
  /// need import 'package:flutter_svg/flutter_svg.dart';
  /// for `SVG` | `JPG | PNG | GIF | JPEG` files
  const ResImagesAnnotation({
    /// example: CustomImages
    required this.className,

    /// example: assets/images/
    required this.assetsDirectory,

    /// example: true(svg) or false(image)
    required this.isSvg,
  });
}
