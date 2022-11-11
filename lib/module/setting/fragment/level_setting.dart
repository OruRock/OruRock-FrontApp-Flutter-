import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';

class LevelSetting extends GetView<SettingController> {
  const LevelSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '레벨 설정',
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(WidthWithRatio.small,
              HeightWithRatio.xxSmall, WidthWithRatio.small, 0),
          child: Column(
            children: [
              Obx(
                () => Container(
                  decoration: noShadowBoxDecoration,
                  padding: const EdgeInsets.symmetric(
                      horizontal: GapSize.small, vertical: GapSize.small),
                  width: Get.width,
                  child: Column(
                    children: [
                      Image.asset(
                        controller.app.levelImage[controller.userLevel.value],
                        width: WidthWithRatio.xxxLarge,
                      ),
                      const SizedBox(
                        height: GapSize.medium,
                      ),
                      Text(
                        controller.nickname.value,
                        style: const TextStyle(
                            fontFamily: "NotoB", fontSize: FontSize.large),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: GapSize.small,
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  decoration: noShadowBoxDecoration,
                  padding: const EdgeInsets.all(GapSize.small),
                  child: GridView.builder(
                    itemCount: controller.app.levelImage.length, //item 개수
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                      childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1.3 의 비율
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          controller.setUserLevel(index);
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(GapSize.xxxSmall,
                              0, GapSize.xxxSmall, GapSize.xxSmall),
                          decoration: noShadowBoxDecoration,
                          child: Image.asset(controller.app.levelImage[index]),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: GapSize.small,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
