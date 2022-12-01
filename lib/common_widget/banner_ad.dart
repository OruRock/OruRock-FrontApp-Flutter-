import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:oru_rock/constant/config.dart';
import 'package:oru_rock/constant/style/size.dart';

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
    _loadAd();
    super.didChangeDependencies();
  }

  Future<void> _loadAd() async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            (Get.width - GapSize.medium * 2).truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    _bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? Config.aos_banner_test_id
          : Config.ios_banner_test_id,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    return _bannerAd!.load();
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
      return SizedBox(
        width: _bannerAd!.size.width.toDouble() - GapSize.medium * 2,
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(
          ad: bannerAd,
        ),
      );
    } else {
      return SizedBox(
        height: Get.height * 0.075,
      );
    }
  }
}
