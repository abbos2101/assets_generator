# ResGenerator
<?code-excerpt path-base="example/lib"?>

[![pub package](https://img.shields.io/pub/v/res_generator.svg)](https://pub.dev/packages/res_generator)

This is a generator and translator for image, icon and words in package assets.

## Usage

Create `res_generator.yaml` in the project folder, under the line `pupspec.yaml`. This file contains the configurations. Change it to suit yourself. It has words, icons, images, if you don't need them, don't add them, just add the ones you need with all their properties.

#### res_generator.yaml
<?code-excerpt "readme_excerpts.dart (Write)"?>
```dart
words:
  assets_directory: assets/tr/
  class_directory: lib/core/common/words/
  class_file: words.dart
  class_name: Words
  supported_locales: [ 'uz', 'en' ]
  target_locale: 'uz'

icons:
  assets_directory: assets/icons/
  class_directory: lib/widgets/
  class_file: custom_icons.dart
  class_name: CustomIcons

images:
  assets_directory: assets/images/
  class_directory: lib/widgets/
  class_file: custom_images.dart
  class_name: CustomImages
```

### add `pubspec.yaml`
<?code-excerpt "readme_excerpts.dart (Write)"?>
```dart
dev_dependencies:
  res_generator: ^version
```

### run command for generate resource(image, icon, words) in terminal
<?code-excerpt "readme_excerpts.dart (Write)"?>
```dart
dart run res_generator:generate
```

### run command for translate resource(words) in terminal
<?code-excerpt "readme_excerpts.dart (Write)"?>
```dart
dart run res_generator:translate
```

## Extra info

`*.dart` and `*.res.dart` files are created.
You can change `*.dart` to these, example given. And don't make changes to `*.res.dart` it will be generated.