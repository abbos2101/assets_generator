import 'package:easy_localization/easy_localization.dart';

part 'words.g.dart';

/// You can change code and method names
/// use any package for example easy_localization
/// use Words.hello.str() or str(Words.hello)
extension MyString on String {
  String str() => this.tr();
}

String str(String key) => key.tr();
