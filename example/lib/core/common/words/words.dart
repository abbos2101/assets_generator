import 'package:assets_annotations/annotations.dart';
import 'package:easy_localization/easy_localization.dart';

part 'words.g.dart';

@AssetsLocalesAnnotation(
  assetsDirectory: 'assets/tr/',
  supportedLocales: ['uz', 'en'],
  targetLocale: 'uz',
)
abstract class Words {
  const Words._();
}

extension MyString on String {
  String genTr() {
    //use any package for example easy_localization
    return tr(this);
  }
}
