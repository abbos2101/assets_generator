import 'package:example/core/common/words/words.dart';
import 'package:example/widgets/custom_icons.dart';
import 'package:example/widgets/custom_images.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('uz'), Locale('en')],
      path: 'assets/tr',
      fallbackLocale: const Locale('uz'),
      useOnlyLangCode: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppWords.appName.genTr())),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.setLocale(context.locale == const Locale('uz')
              ? const Locale('en')
              : const Locale('uz'));
        },
        child: CustomIconsGen.world.copyWith(
          width: 24,
          colorFilter: const ColorFilter.mode(
            Colors.blueAccent,
            BlendMode.srcIn,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconsGen.cancel.copyWith(width: 24),
                const SizedBox(width: 8),
                Text(AppWords.cancel.genTr()),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconsGen.delete.copyWith(width: 24),
                const SizedBox(width: 8),
                Text(AppWords.delete.genTr()),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImagesGen.cat.copyWith(width: 24),
                const SizedBox(width: 8),
                Text(AppWords.cat.genTr()),
              ],
            ),
            const SizedBox(height: 8),
            CustomImagesGen.catGif.copyWith(width: 200),
          ],
        ),
      ),
    );
  }
}
