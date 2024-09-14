class ResWordsAnnotation {
  final String className;
  final String assetsDirectory;
  final List<String> supportedLocales;
  final String targetLocale;

  /// for localization generate. Need add pubspec.yaml `easy_localization` package
  const ResWordsAnnotation({
    /// example: Words
    required this.className,

    /// example: assets/tr/
    required this.assetsDirectory,

    /// example: ['uz_UZ', 'ru_RU']
    /// or ['uz', 'ru']
    required this.supportedLocales,

    /// example: 'uz' or 'uz_Uz'
    required this.targetLocale,
  });
}
