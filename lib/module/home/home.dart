import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:oru_rock/common_widget/banner_ad.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/module/app/app_controller.dart';
import 'package:oru_rock/module/home/fragment/home_service_top.dart';
import 'package:oru_rock/routes.dart';

class Home extends GetView<AppController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
/*            ElevatedButton(onPressed: (){
              controller.signOut();
            }, child: Text('로그아웃')),*/
            SizedBox(
              height: HeightWithRatio.xxxxSmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: GapSize.medium, vertical: GapSize.small),
              child: Row(
                children: [
                  const CircleAvatar(
                    minRadius: 20,
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Text(
                    '${controller.auth.user!.displayName}님,\n오늘도 안전하고 즐거운 클라이밍 되세요!',
                    style: const TextStyle(
                        fontSize: FontSize.medium,
                        fontFamily: "NotoB",
                        height: 1.7),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(GapSize.medium),
              child: HomeServiceTop(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GapSize.medium),
              child: SizedBox(
                height: HeightWithRatio.medium,
                width: Get.width,
                child: const Center(child: Text("admob Banner")),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: GapSize.medium, vertical: GapSize.small),
              child: Text(
                '즐겨찾는 암장',
                style: TextStyle(fontSize: FontSize.large, fontFamily: "NotoB"),
              ),
            ),
            _buildListTile(),
            _buildListTile(),
            _buildListTile(),
            _buildListTile(),
            _buildListTile(),
            _buildListTile(),
            _buildListTile(),
          ],
        ),
      ),
    );
  }

  _buildListTile() {
    return const Center(
      child: ListTile(
        title: Text('암장 1'),
      ),
    );
  }
}
