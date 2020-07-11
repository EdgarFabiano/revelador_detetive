import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

import 'constants.dart';

class AdUnits {

  static final String androidApiKey = "ca-app-pub-9921693044196842~1268647503";
  static final String androidBanner = "ca-app-pub-9921693044196842/9987723705";
  static final String androidInterstitial = "ca-app-pub-9921693044196842/2004457756";

  static BannerAd _banner;
  static BannerAd get banner => _banner;

  static InterstitialAd _interstitial;
  static InterstitialAd get interstitial => _interstitial;

  static void instatiateBannerAd() {
    _banner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdUnits.getBannerId(),
      targetingInfo: MobileAdTargetingInfo(
          testDevices: [
            "30B81A47E3005ADC205D4BCECC4450E1",
            "F2EFF4F833C2BA2BE93D3A4A1098A125",
            "420CBC41672019D607F67499A344FD38"
          ]
      ),
    );
  }

  static void instatiateInterstitialAd() {
    _interstitial = InterstitialAd(
      adUnitId: AdUnits.getInterstitialId(),
      targetingInfo: MobileAdTargetingInfo(
          testDevices: [
            "30B81A47E3005ADC205D4BCECC4450E1",
            "F2EFF4F833C2BA2BE93D3A4A1098A125",
            "420CBC41672019D607F67499A344FD38"
          ]
      ),
    );
  }

  static void showBannerAd() {
    _banner.isLoaded().then((isLoaded) {
      if (isLoaded) {
        _banner.show();
      } else {
        instatiateBannerAd();
        _banner.load();
      }
    });
  }

  static void showInterstitialAd() {
    _interstitial.isLoaded().then((isLoaded) {
      if (isLoaded) {
        _interstitial.show();
      } else {
        instatiateInterstitialAd();
        _interstitial.load();
      }
    });
  }

  static String getAppId() {
    if (Platform.isAndroid) {
      return androidApiKey;
    }
    return FirebaseAdMob.testAppId;
  }

  static String getBannerId() {
    if (!Constants.isTesting) {
      return androidBanner;
    }
    return BannerAd.testAdUnitId;
  }

  static String getInterstitialId() {
    if (!Constants.isTesting) {
      return androidInterstitial;
    }
    return InterstitialAd.testAdUnitId;
  }
}
