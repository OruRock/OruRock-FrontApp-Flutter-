import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/common_widget/instagram_button.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/setting/fragment/change_nickname.dart';
import 'package:oru_rock/module/setting/fragment/level_setting.dart';
import 'package:oru_rock/module/setting/fragment/my_bookmark_list.dart';
import 'package:oru_rock/module/setting/fragment/my_review_list.dart';
import 'package:oru_rock/module/setting/fragment/notice_list.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';

class Setting extends GetView<SettingController> {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Obx(
          () => Padding(
            padding: EdgeInsets.fromLTRB(WidthWithRatio.small,
                HeightWithRatio.xSmall, WidthWithRatio.small, 0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  decoration: noShadowBoxDecoration,
                  padding: const EdgeInsets.symmetric(
                      horizontal: GapSize.small, vertical: GapSize.small),
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: GapSize.xxxSmall),
                            child: Image.asset(
                              controller.app
                                  .levelImage[controller.userLevel.value ?? 0],
                              width: WidthWithRatio.xxLarge,
                            ),
                          ),
                          const SizedBox(
                            width: GapSize.small,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: GapSize.xSmall,
                                  ),
                                  Text(
                                    controller.nickname.value,
                                    style: const TextStyle(
                                        fontFamily: "NotoM",
                                        fontSize: FontSize.small),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: GapSize.xxSmall,
                              ),
                              const InstagramButton(
                                nickName: 'climb_developer',
                              ),
                              const SizedBox(
                                height: GapSize.xxSmall,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    '↕ 162',
                                    style: TextStyle(
                                        fontFamily: "NotoB",
                                        fontSize: FontSize.medium),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: GapSize.xSmall),
                                    child: Text('|'),
                                  ),
                                  Text(
                                    '↔ 162',
                                    style: TextStyle(
                                        fontFamily: "NotoB",
                                        fontSize: FontSize.medium),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: GapSize.medium,
                      ),
                      //TODO 데이터 값으로 변경 필요
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: const [
                              Text(
                                '리뷰',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "NotoM",
                                ),
                              ),
                              SizedBox(
                                height: GapSize.xxxSmall,
                              ),
                              Text('30',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "NotoB",
                                  ))
                            ],
                          ),
                          Column(
                            children: const [
                              Text('추천',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "NotoM",
                                  )),
                              SizedBox(
                                height: GapSize.xxxSmall,
                              ),
                              Text('30',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "NotoB",
                                  ))
                            ],
                          ),
                          InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: noShadowBoxDecoration,
                                  padding: EdgeInsets.all(GapSize.xSmall),
                                  child: Text('수정',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "NotoM",
                                          color: Colors.grey))))
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
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
                    onTap: () {
                      Get.to(const LevelSetting());
                    },
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
                    onTap: () async {
                      controller.myReviewList.value =
                          await controller.getMyReview();
                      Get.to(const MyReviewList());
                    },
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
                    onTap: () {
                      Get.to(const MyBookmarkList());
                    },
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
                const Divider(
                  height: 1.0,
                  thickness: 1.0,
                ),
                const SizedBox(
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
                    onTap: () {
                      Get.to(const NoticeList());
                    },
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
                    onTap: () {
                      Get.to(const ChangeNickname());
                    },
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
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: GapSize.small),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '앱 버전',
                            style: TextStyle(
                                fontSize: FontSize.medium,
                                fontFamily: "NotoR",
                                color: Colors.black87),
                          ),
                          Text(
                            'v ${controller.appVersion.value}',
                            style: const TextStyle(
                                fontSize: FontSize.medium,
                                fontFamily: "NotoR",
                                color: Colors.grey),
                          ),
                        ],
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
      ),
    );
  }
}
