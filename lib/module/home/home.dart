import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/common_widget/banner_ad.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/app/app_controller.dart';
import 'package:oru_rock/module/home/fragment/home_favorites.dart';
import 'package:oru_rock/module/home/fragment/home_service_top.dart';

import 'fragment/home_pin.dart';

class Home extends GetView<AppController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: const [
/*            const Padding(
              padding: EdgeInsets.symmetric(vertical: GapSize.small),
              child: Center(
                  child: Text(
                '오 르 락',
                style: TextStyle(fontFamily: "JungMock", fontSize: 70),
              )),
            ),*/
            HomePin(),
            Padding(
              padding: EdgeInsets.all(GapSize.medium),
              child: HomeServiceTop(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: GapSize.medium),
              child: BannerAdWidget(),
            ),
            HomeFavorites(),
          ],
        ),
      ),
    );
  }
}
