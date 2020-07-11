import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'defaults/ad-units.dart';
import 'defaults/strings.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _valueResult = "";

  Future<String> _getResult() async {
    return await scanner.scan();
  }

  void _switchTheme(BuildContext context) {
    var b = Theme.of(context).brightness;
    DynamicTheme.of(context).setBrightness(
        b == Brightness.dark ? Brightness.light : Brightness.dark);
  }

  @override
  void initState() {
    AdUnits.instatiateBannerAd();
    AdUnits.banner.load();
    AdUnits.showBannerAd();

    AdUnits.instatiateInterstitialAd();
    AdUnits.interstitial.load();
  }

  @override
  Widget build(BuildContext context) {
    AdUnits.showBannerAd();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Visibility(
                  visible: false,
                  child: IconButton(
                    icon: Icon(Theme.of(context).brightness == Brightness.dark
                        ? Icons.brightness_3
                        : Icons.brightness_high),
                    onPressed: () {
                      _switchTheme(context);
                    },
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              children: <Widget>[
                Text(
                  '$_valueResult',
                  style: Theme.of(context).textTheme.display1,
                ),
                IconButton(
                  onPressed: () {
                    AdUnits.instatiateInterstitialAd();
                    AdUnits.interstitial.load();
                    _getResult().then((onValue) {
                      setState(() {
                        try {
                          var value = int.parse(onValue);
                          if (value <= 27 && value > 0) {
                            _valueResult = Strings.cards[value - 1];
                          } else {
                            _valueResult = 'Código inválido';
                          }
                        } catch (e) {
                          _valueResult = 'Código inválido';
                        }
                        AdUnits.showInterstitialAd();
                      });
                    });
                  },
                  icon: Icon(Icons.camera_alt),
                ),
                Text("Escanear código"),
              ],
            ),
            Spacer(),
            Column(),
            Spacer(),
            Column(),
          ],
        ),
      ),
    );
  }
}
