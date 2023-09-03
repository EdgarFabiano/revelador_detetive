import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../revelador_banner_ad.dart';
import 'constants.dart';

class AdUnits {

  static final String androidApiKey = "ca-app-pub-5932227223136302~8152965106";
  static final String androidBanner = "ca-app-pub-5932227223136302/2326129137";
  static final String androidInterstitial = "ca-app-pub-5932227223136302/9040476995";

  static const int maxFailedLoadAttempts = 3;
  static int _numInterstitialLoadAttempts = 0;

  static final AdRequest request = AdRequest();

  static BannerAd? _banner;
  static BannerAd? get banner => _banner;

  static InterstitialAd? _interstitial;
  static InterstitialAd? get interstitial => _interstitial;

  static var _fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (InterstitialAd ad) =>
        print('$ad onAdShowedFullScreenContent.'),
    onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print('$ad onAdDismissedFullScreenContent.');
      ad.dispose();
      createInterstitialAd();
    },
    onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      print('$ad onAdFailedToShowFullScreenContent: $error');
      ad.dispose();
      createInterstitialAd();
    },
  );

/*banner*/
  static ReveladorBannerAd getBannerAd(String id) {
    ReveladorBannerAd banner = ReveladorBannerAd(
      adUnitId: id,
      request: AdManagerAdRequest(),
      listener: AdManagerBannerAdListener(onAdLoaded: (Ad ad) {
        print('$ad loaded.');
      }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
        print('$ad Failed To Load: $error');
        ad.dispose();
      }, onAdOpened: (Ad ad) {
        print('$ad Ad Opened.');
      }, onAdClosed: (Ad ad) {
        print('$ad Ad Closed.');
        ad.dispose();
      }, onAdImpression: (Ad ad) {
        print('$ad Ad Impression.');
      }, onAdClicked: (Ad ad) {
        print('$ad Ad Clicked.');
      }),
      size: AdSize.largeBanner,
    );
    return banner;
  }

  static Widget getBannerAdWidget(ReveladorBannerAd bannerAd) {
    if (bannerAd.isLoaded) {
      return Container(
        child: AdWidget(ad: bannerAd),
        width: bannerAd.size.width.toDouble(),
        height: bannerAd.size.height.toDouble(),
        alignment: Alignment.center,
      );
    }
    return SizedBox.shrink();
  }

  static void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: androidInterstitial,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitial = ad;
            _interstitial!.fullScreenContentCallback =
                _fullScreenContentCallback;
            _numInterstitialLoadAttempts = 0;
            _interstitial!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitial = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  static void showInterstitialAd() {
      if (_interstitial == null) {
        print('Warning: attempt to show interstitial before loaded.');
        return;
      }
      _interstitial!.show();
  }

  static String getAppId() {
      return androidApiKey;
  }

  static String getBannerId() {
      return androidBanner;
  }

  static String getInterstitialId() {
      return androidInterstitial;
  }
}
