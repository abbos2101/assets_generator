import 'dart:io';
import 'utils/string_variable_extensions.dart';
import 'utils/image_extensions.dart';

class ImageHelper {
  final String assetsDirectory;
  final String classDirectory;
  final String classFile;
  final String className;

  const ImageHelper._({
    this.assetsDirectory = '',
    this.classDirectory = '',
    this.classFile = '',
    this.className = '',
  });

  factory ImageHelper.fromJson(dynamic json) {
    if (json == null) return ImageHelper._();
    return ImageHelper._(
      assetsDirectory: json['assets_directory'] ?? '',
      classDirectory: json['class_directory'] ?? '',
      classFile: json['class_file'] ?? '',
      className: json['class_name'] ?? '',
    );
  }

  void generate() {
    if (assetsDirectory.isNotEmpty &&
        classDirectory.isNotEmpty &&
        classFile.isNotEmpty &&
        classFile.lastIndexOf('.dart') != -1 &&
        className.isNotEmpty) {
      final assetsDir = Directory(assetsDirectory);
      if (!assetsDir.existsSync()) {
        print('Error: Assets directory $assetsDir does not exist.');
        return;
      }

      final classDir = Directory(classDirectory);
      if (!classDir.existsSync()) {
        classDir.createSync(recursive: true);
        print('Class directory $classDir does not exist.');
      }

      final strPart = stringPart(
        classFileName: classFile.name,
        className: className,
      );
      final strPartOf = stringPartOf(
        assetsDirectory: assetsDir,
        classFileName: classFile.name,
        className: className,
      );

      final filePart = File('$classDirectory${classFile.name}.dart');
      final filePartOf = File('$classDirectory${classFile.name}.res.dart');

      if (!filePart.existsSync()) {
        filePart.writeAsStringSync(strPart);
        print('${className.name}.dart has been created.');
      }

      if (filePartOf.existsSync()) {
        if (filePartOf.readAsStringSync().removeExtraSpaces() !=
            strPartOf.removeExtraSpaces()) {
          filePartOf.writeAsStringSync(strPartOf);
          print('${className.name}.res.dart has been updated.');
        }
      } else {
        filePartOf.writeAsStringSync(strPartOf);
        print('${className.name}.res.dart has been created.');
      }
    }
  }
}
