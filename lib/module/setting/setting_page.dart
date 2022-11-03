import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';

class Setting extends GetView<SettingController> {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            '설정',
            style: TextStyle(
                fontFamily: "NotoB",
                fontSize: FontSize.xLarge,
                height: 1.7,
                color: Colors.black),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(WidthWithRatio.small,
              HeightWithRatio.xSmall, WidthWithRatio.small, 0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                decoration: noShadowBoxDecoration,
                padding: const EdgeInsets.symmetric(horizontal: GapSize.small, vertical: GapSize.small),
                width: Get.width,
                child: Column(
                  children: [
                    Image.asset('asset/image/logo/splash_logo.png', width: WidthWithRatio.xxxLarge,),
                    const SizedBox(
                      height: GapSize.medium,
                    ),
                    Text('${controller.auth.user!.displayName}', style: TextStyle(fontFamily: "NotoB", fontSize: FontSize.large),),
                  ],
                ),
              ),
              SizedBox(
                height: GapSize.medium,
              ),
              const Text(
                '프로필 설정',
                style: TextStyle(
                    fontFamily: "NotoM",
                    fontSize: FontSize.xSmall,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: GapSize.xxSmall,
              ),
              SizedBox(
                width: Get.width,
                child: GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: GapSize.small),
                    child: Text(
                      '나의 트로피',
                      style: TextStyle(
                          fontSize: FontSize.medium,
                          fontFamily: "NotoR",
                          color: Colors.black87),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width,
                child: GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: GapSize.small),
                    child: Text(
                      '나의 리뷰',
                      style: TextStyle(
                          fontSize: FontSize.medium,
                          fontFamily: "NotoR",
                          color: Colors.black87),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width,
                child: GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: GapSize.small),
                    child: Text(
                      '즐겨찾는 암장',
                      style: TextStyle(
                          fontSize: FontSize.medium,
                          fontFamily: "NotoR",
                          color: Colors.black87),
                    ),
                  ),
                ),
              ),
              Divider(height: 1.0, thickness: 1.0,),
              SizedBox(
                height: GapSize.small,
              ),
              const Text(
                '환경 설정',
                style: TextStyle(
                    fontFamily: "NotoM",
                    fontSize: FontSize.xSmall,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: GapSize.xxSmall,
              ),
              SizedBox(
                width: Get.width,
                child: GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: GapSize.small),
                    child: Text(
                      '공지사항',
                      style: TextStyle(
                          fontSize: FontSize.medium,
                          fontFamily: "NotoR",
                          color: Colors.black87),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width,
                child: GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: GapSize.small),
                    child: Text(
                      '닉네임 변경',
                      style: TextStyle(
                          fontSize: FontSize.medium,
                          fontFamily: "NotoR",
                          color: Colors.black87),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width,
                child: GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: GapSize.small),
                    child: Text(
                      '앱 버전',
                      style: TextStyle(
                          fontSize: FontSize.medium,
                          fontFamily: "NotoR",
                          color: Colors.black87),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width,
                child: GestureDetector(
                  onTap: () {
                    controller.signOut();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: GapSize.small),
                    child: Text(
                      '로그아웃',
                      style: TextStyle(
                          fontSize: FontSize.medium,
                          fontFamily: "NotoR",
                          color: Colors.redAccent),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
