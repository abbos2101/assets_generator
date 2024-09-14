import 'package:easy_localization/easy_localization.dart';
import 'package:res_generator_annotation/res_generator_annotation.dart';

part 'words.g.dart';

@ResWordsAnnotation(
  className: 'Words',
  assetsDirectory: 'assets/tr/',
  supportedLocales: ['uz', 'en'],
  targetLocale: 'uz',
)
extension MyString on String {
  String genTr() {
    //use any package for example easy_localization
    return tr(this);
  }
}
