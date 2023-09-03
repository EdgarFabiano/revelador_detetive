import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revelador_detetive/defaults/strings.dart';
import 'package:revelador_detetive/revelador_banner_ad.dart';
import 'package:revelador_detetive/scan_qr_page.dart';

import 'defaults/ad-units.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _valueResult = "";

  ReveladorBannerAd _bannerAd = AdUnits.getBannerAd(AdUnits.androidBanner);

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
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
            TextButton(
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

  Future<PermissionStatus> _getCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return result;
    } else {
      return status;
    }
  }

  void scanCode() async {
    //AdUnits.createInterstitialAd();

    PermissionStatus status = await _getCameraPermission();
    if (status.isGranted) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) => ScanQrPage(onResult: _getResult),
            fullscreenDialog: true),
      );
    }

  }

  Future<void> _getResult(String? onValue) async {
    setState(() {
      try {
        var value = int.parse(onValue!);
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
  }

  void clear() {
    setState(() {
      _valueResult = "";
    });
  }

  @override
  void initState() {
    super.initState();
    _bannerAd.load();

    AdUnits.createInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(child: Container()),
            Center(
              child: Column(
                children: [
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
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Visibility(
                            visible: _valueResult != "",
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
                  )
                ],
              ),
            ),
            Expanded(child: Container()),
            AdUnits.getBannerAdWidget(_bannerAd),
          ],
        ),
      ),
    );
  }
}
