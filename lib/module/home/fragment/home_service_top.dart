import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/home/home_controller.dart';

import 'package:oru_rock/routes.dart';

class HomeServiceTop extends GetView<HomeController> {
  const HomeServiceTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: controller.isPinned.value,
          child: Container(
            height: HeightWithRatio.medium,
            decoration: shadowBoxDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.pin_drop_outlined),
                Expanded(
                  child: Text('고정한 암장'),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: GapSize.medium,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                width: WidthWithRatio.xxxLarge,
                height: WidthWithRatio.xxxLarge,
                decoration: shadowBoxDecoration,
                child: Material(
                  borderRadius: BorderRadius.circular(RadiusSize.large),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(RadiusSize.large)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(RadiusSize.large),
                      onTap: () {},
                      child: const Center(child: Text('검색')),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: GapSize.medium,
            ),
            Expanded(
              child: Container(
                width: WidthWithRatio.xxxLarge,
                height: WidthWithRatio.xxxLarge,
                decoration: shadowBoxDecoration,
                child: Material(
                  borderRadius: BorderRadius.circular(RadiusSize.large),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(RadiusSize.large)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(RadiusSize.large),
                      onTap: () {
                        Get.toNamed(Routes.nmap);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom:GapSize.small, left: GapSize.small),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: DefaultTextStyle(
                            style: const TextStyle(fontSize: FontSize.medium, fontFamily: 'NanumB', color: Colors.black, height: 1.5),
                            child: AnimatedTextKit(
                              displayFullTextOnTap: true,
                              repeatForever: true,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                    speed: const Duration(milliseconds: 150),
                                    '내 주변\n클라이밍장 찾기'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
