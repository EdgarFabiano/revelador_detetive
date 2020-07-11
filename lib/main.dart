import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:revelador_detetive/defaults/themes.dart';

import 'defaults/strings.dart';
import 'home-page.dart';
import 'defaults/ad-units.dart';

void main()  {
  FirebaseAdMob.instance.initialize(appId: AdUnits.getAppId());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
        primarySwatch: DefaultThemes.primaryLight,
        brightness: brightness,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: Strings.appName,
          theme: ThemeData(
            primarySwatch: DefaultThemes.primaryLight,
          ),
          home: HomePage(title: Strings.appName),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
