# ResGenerator

[![pub package](https://img.shields.io/pub/v/res_generator.svg)](https://pub.dev/packages/res_generator)

Rasm, icon va lokalizatsiya uchun o'rnatilgan tarjima qo'llab-quvvatlashli Flutter kod generatori.

<br>
---

**[English](https://github.com/abbos2101/res_generator#readme)** | **[O'zbekcha](https://github.com/abbos2101/res_generator/blob/main/README_UZ.md)**

---

<br>

![Foydalanish](https://raw.githubusercontent.com/abbos2101/res_generator/main/assets/use-case-uz.png)

## Xususiyatlar

- ✅ SVG iconlar va PNG/JPG rasmlardan avtomatik Dart klasslari yaratish
- ✅ Lokalizatsiya fayllarini avtomatik yaratish va tarjima qilish
- ✅ `easy_localization` va shunga o'xshash packagelar bilan muammosiz integratsiya
- ✅ Xavfsiz resurs kirishi (type-safe)
- ✅ Sozlash uchun qulay `copyWith` metodlari

## O'rnatish

`pubspec.yaml` faylingizga qo'shing:
```yaml
dev_dependencies:
  res_generator: ^version
```

## Sozlash

Loyiha ildizida (ya'ni `pubspec.yaml` yonida) `res_generator.yaml` fayl yarating:
```yaml
words:
  assets_directory: assets/tr/
  class_directory: lib/core/common/words/
  class_file: words.dart
  class_name: Words
  supported_locales: ['uz', 'en', 'ru']  # yoki ['uz-UZ', 'en-EN', 'ru-RU']
  translated_locales: ['en', 'ru']        # tarjima qilinadigan tillar
  target_locale: 'uz'                     # manba til

icons:
  assets_directory: assets/icons/
  class_directory: lib/widgets/
  class_file: app_icons.dart
  class_name: AppIcons

images:
  assets_directory: assets/images/
  class_directory: lib/widgets/
  class_file: app_images.dart
  class_name: AppImages
```

## Ishlatish

### Resurslarni yaratish
```bash
dart run res_generator:generate
```

### Lokalizatsiyani tarjima qilish
```bash
dart run res_generator:translate
```

## Kod misollari

### Iconlar
```dart
// Oddiy ishlatish
Scaffold(body: AppIcons.logo)

// Sozlash bilan
AppIcons.logo.copyWith(
  width: 24,
  height: 24,
  fit: BoxFit.fill,
  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
)

// Path orqali to'g'ridan-to'g'ri ishlatish
SvgPicture.asset(AppIcons.logo.path)
```

### Rasmlar
```dart
// Oddiy ishlatish
Scaffold(body: AppImages.splash)

// Sozlash bilan
AppImages.splash.copyWith(
  width: double.infinity,
  height: double.infinity,
  fit: BoxFit.cover,
)

// Path orqali to'g'ridan-to'g'ri ishlatish
Image.asset(AppImages.splash.path)
```

### Lokalizatsiya
```dart
// 1-usul # O'zgarmas so'zlar uchun tafsiya etiladi
Text(Words.documents.str)

// 2-usul # O'zgaruvchan so'zlar uchun tafsiya etiladi
Text("documents".str)

// 3-usul
Text(str(Words.documents))

// 4-usul
Text(str("documents"))
```

## Yaratilgan fayllar

Generator ikki turdagi fayllar yaratadi:

- `*.dart` - O'zgartirish uchun xavfsiz
- `*.res.dart` - Avtomatik yaratilgan, o'zgartirmang (qayta yoziladi)