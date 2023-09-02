import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:revelador_detetive/defaults/themes.dart';

import 'defaults/ad-units.dart';
import 'defaults/strings.dart';
import 'home-page.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return EasyDynamicThemeWidget(
      child: ReveladorMaterialApp(),
    );
  }
}

class ReveladorMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: DefaultThemes.appTheme(),
      darkTheme: DefaultThemes.darkTheme(),
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: HomePage(title: Strings.appName),
      debugShowCheckedModeBanner: false,
    );
  }
}