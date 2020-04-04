import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:revelador_detetive/defaults/themes.dart';

import 'HomePage.dart';
import 'defaults/ad-units.dart';

void main()  {
  FirebaseAdMob.instance.initialize(appId: AdUnits.getAppId());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revelador Detetive',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: DefaultThemes.primaryLight,
      ),
      home: HomePage(title: 'Revelador'),
    );
  }
}
