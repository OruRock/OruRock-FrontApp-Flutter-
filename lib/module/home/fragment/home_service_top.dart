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
        Obx(
          () => Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: GapSize.small),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '클라이밍장 찾기',
                    style: TextStyle(
                        fontSize: FontSize.large, fontFamily: "NotoB"),
                  ),
                ),
              ),
              Visibility(
                visible: controller.isPinned.value,
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
                            child: controller.stores.isEmpty
                                ? Container()
                                : Center(
                                    child: Text(
                                      controller.pinnedStoreName.value,
                                      style: pinTextStyle,
                                    ),
                                  )),
                        IconButton(
                            onPressed: () {
                              controller.removePin();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 20,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
                            padding: const EdgeInsets.only(
                                bottom: GapSize.small, left: GapSize.small),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                    fontSize: FontSize.small,
                                    fontFamily: 'NotoB',
                                    color: Colors.black,
                                    height: 1.5),
                                child: AnimatedTextKit(
                                  displayFullTextOnTap: true,
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                        speed:
                                            const Duration(milliseconds: 150),
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
                            padding: const EdgeInsets.only(
                                bottom: GapSize.small, left: GapSize.small),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                    fontSize: FontSize.small,
                                    fontFamily: 'NotoB',
                                    color: Colors.black,
                                    height: 1.5),
                                child: AnimatedTextKit(
                                  displayFullTextOnTap: true,
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                        speed:
                                            const Duration(milliseconds: 150),
                                        '내 주변 클라이밍장 찾기'),
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
