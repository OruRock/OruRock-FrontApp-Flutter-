import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/app/app_controller.dart';

class HomeServiceTop extends GetView<AppController> {
  const HomeServiceTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '클라이밍장 찾기',
            style: TextStyle(fontSize: FontSize.large, fontFamily: "NotoB"),
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
                      onTap: () {
                        controller.selectedTabIndex.value = Tabs.search;
                      },
                      child: Column(
                        children: [
                          Expanded(child: Container()),
                          Image.asset(
                            'asset/image/icon/search_icon.png',
                            height: WidthWithRatio.xxLarge,
                          ),
                          SizedBox(
                            height: WidthWithRatio.small,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: GapSize.small),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                    fontSize: FontSize.medium,
                                    fontFamily: 'NotoM',
                                    color: Colors.black,
                                    height: 1.5),
                                child: AnimatedTextKit(
                                  displayFullTextOnTap: true,
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                        speed:
                                            const Duration(milliseconds: 120),
                                        '검색으로 찾기'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                        controller.selectedTabIndex.value = Tabs.nmap;
                      },
                      child: Column(
                        children: [
                          Expanded(child: Container()),
                          Image.asset(
                            'asset/image/icon/map_icon.png',
                            height: WidthWithRatio.xxLarge,
                          ),
                          SizedBox(
                            height: WidthWithRatio.small,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: GapSize.small),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                    fontSize: FontSize.medium,
                                    fontFamily: 'NotoM',
                                    color: Colors.black,
                                    height: 1.5),
                                child: AnimatedTextKit(
                                  displayFullTextOnTap: true,
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                        textAlign: TextAlign.start,
                                        speed:
                                            const Duration(milliseconds: 120),
                                        '내 근처에서 찾기'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
