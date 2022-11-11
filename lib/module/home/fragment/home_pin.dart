import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/app/app_controller.dart';

class HomePin extends GetView<AppController> {
  const HomePin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.isPinned.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                  GapSize.medium, GapSize.small, GapSize.medium, GapSize.small),
              child: Text(
                '오늘 갈 암장',
                style: TextStyle(fontSize: FontSize.large, fontFamily: "NotoB"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GapSize.medium),
              child: GestureDetector(
                onTap: () {
                  controller.goMapToSelectedStore(controller.pinnedStoreId!);
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
    );
  }
}
