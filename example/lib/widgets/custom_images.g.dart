// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_images.dart';

// **************************************************************************
// ResImagesGenerator
// **************************************************************************

abstract class CustomImagesGen {
  const CustomImagesGen._();

  static final catGif = Image.asset('assets/images/cat_gif.webp');
  static final cat = Image.asset('assets/images/cat.png');
}

extension ExtensionCustomImagesGen on Image {
  Image copyWith({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return Image(
      image: image,
      width: width ?? this.width,
      height: height ?? this.height,
      fit: fit ?? this.fit,
      color: color ?? this.color,
    );
  }

  String get path {
    final path = "$image";
    const key = ', name: "';
    if (path.contains(key)) {
      return path.substring(path.indexOf(key) + key.length, path.length - 2);
    }
    return "";
  }
}
