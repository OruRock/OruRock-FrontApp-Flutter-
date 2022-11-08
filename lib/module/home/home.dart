import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:oru_rock/common_widget/banner_ad.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/app/app_controller.dart';
import 'package:oru_rock/module/home/fragment/home_favorites.dart';
import 'package:oru_rock/module/home/fragment/home_service_top.dart';
import 'package:flutter/material.dart';

class Home extends GetView<AppController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView(
          children: [
            SizedBox(
              height: HeightWithRatio.xLarge,
              child: Center(child: Text('오 르 락', style: TextStyle(fontFamily: "JungMock", fontSize: 70),)),
            ),
/*            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GapSize.medium),
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
                  AutoSizeText(
                    '${controller.auth.user!.displayName}님,\n오늘도 즐거운 클라이밍 되세요!',
                    maxLines: 2,
                    minFontSize: FontSize.medium,
                    maxFontSize: FontSize.large,
                    style: const TextStyle(
                        fontFamily: "NotoM",
                        height: 1.7),
                  ),
                ],
              ),
            ),*/
            Obx(
              () => Visibility(
                visible: controller.isPinned.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: GapSize.medium, vertical: GapSize.small),
                      child: Text(
                        '오늘 갈 암장',
                        style: TextStyle(
                            fontSize: FontSize.large, fontFamily: "NotoB"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GapSize.medium),
                      child: GestureDetector(
                        onTap: () {
                          controller
                              .goMapToSelectedStore(controller.pinnedStoreId!);
                        },
                        child: Container(
                          height: HeightWithRatio.small,
                          decoration: shadowBoxDecoration,
                          child: Padding(
                            padding: const EdgeInsets.only(left: GapSize.small),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'asset/image/icon/pin_icon.png',
                                  height: HeightWithRatio.xxxSmall,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      controller.pinnedStoreName.value,
                                      style: pinTextStyle,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    controller.removePin();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                child: const Center(child: BannerAdWidget()),
              ),
            ),
            HomeFavorites(),
          ],
        ),
      ),
    );
  }
}
