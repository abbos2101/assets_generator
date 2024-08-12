class AssetsLocalesAnnotation {
  final String assetsDirectory;
  final List<String> supportedLocales;
  final String targetLocale;
  final String prefix;

  /// for localization generate. Need add pubspec.yaml `easy_localization` package
  const AssetsLocalesAnnotation({
    /// example: assets/tr/
    required this.assetsDirectory,

    /// example: ['uz_UZ', 'ru_RU']
    /// or ['uz', 'ru']
    required this.supportedLocales,

    /// example: 'uz' or 'uz_Uz'
    required this.targetLocale,

    /// example: 'App'
    this.prefix = 'App',
  });
}
