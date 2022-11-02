import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:oru_rock/constant/config.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  var isAdLoaded = false;

  @override
  void didChangeDependencies() {
    // Create the ad objects and load ads.
    _bannerAd = BannerAd(
        adUnitId: Platform.isAndroid
            ? Config.aos_banner_test_id
            : Config.ios_banner_test_id,
        request: AdRequest(),
        size: AdSize.fullBanner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, err) {
            print('Failed to load a banner ad: ${err.message}');
            ad.dispose();
          },
        ))
      ..load();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BannerAd? bannerAd = _bannerAd;

    if (isAdLoaded && bannerAd != null) {
      return AdWidget(
        ad: bannerAd,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
