// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_icons.dart';

// **************************************************************************
// ResImagesGenerator
// **************************************************************************

abstract class CustomIconsGen {
  const CustomIconsGen._();

  static final cancel = SvgPicture.asset('assets/icons/cancel.svg');
  static final world = SvgPicture.asset('assets/icons/world.svg');
  static final delete = SvgPicture.asset('assets/icons/delete.svg');
  static final help = SvgPicture.asset('assets/icons/help.svg');
}

extension ExtensionCustomIconsGen on SvgPicture {
  SvgPicture copyWith({
    double? width,
    double? height,
    BoxFit? fit,
    ColorFilter? colorFilter,
  }) {
    return SvgPicture.asset(
      path,
      width: width ?? this.width,
      height: height ?? this.height,
      fit: fit ?? this.fit,
      colorFilter: colorFilter ?? this.colorFilter,
    );
  }

  String get path => "$bytesLoader".substring(15, "$bytesLoader".length - 1);
}
