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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Como funciona'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Para revelar uma carta do jogo Detetive, toque em \'Escanear código\' e aponte a câmera para o QR code no verso da mesma.')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black87),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void scanCode() {
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
  }

  void clear() {
    setState(() {
      _valueResult = "";
    });
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
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showMyDialog,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: scanCode,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Icon(Icons.camera_alt),
                      Text("Escanear código"),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$_valueResult',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    Visibility(
                      visible: _valueResult != null && _valueResult != "",
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: IconButton(
                          onPressed: clear,
                          icon: Icon(Icons.clear),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
