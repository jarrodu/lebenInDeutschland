import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/cache/cache_manager.dart';
import 'package:leben_in_deutschland/provider/theme_notifier.dart';
import 'package:leben_in_deutschland/screens/home_page.dart';
import 'package:leben_in_deutschland/theme/custom_theme.dart';
import 'package:leben_in_deutschland/viewModels/question_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheManager.instance.initPreferences().then((value) {
    CacheManager.instance.getThemePref().then((theme) {
      runApp(
        ChangeNotifierProvider<ThemeNotifier>(
          create: (BuildContext context) {
            if (theme == null) {
              CacheManager.instance.setThemePref(false);
              return ThemeNotifier(ThemeMode.dark);
            }
            return ThemeNotifier(theme ? ThemeMode.light : ThemeMode.dark);
          },
          child: const MyApp(),
        ),
      );
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MultiProvider(
      providers: [
        Provider<QuestionViewModel>(create: (_) => QuestionViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Leben In Deutschland',
        theme: CustomTheme().lightTheme,
        darkTheme: CustomTheme().darkTheme,
        themeMode: themeNotifier.getThemeMode(),
        home: const HomePage(),
      ),
    );
  }
}
