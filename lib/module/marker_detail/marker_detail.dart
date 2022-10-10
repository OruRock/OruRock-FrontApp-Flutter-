import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/model/store_model.dart' as model;
import 'package:oru_rock/module/marker_detail/marker_detail_controller.dart';

class MarkerDetail extends GetView<MarkerDetailController> {
  final model.StoreModel? store;

  const MarkerDetail({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(RadiusSize.large)),
          ),
          height: Get.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: GapSize.xxSmall),
          child: Container(
            height: Get.height * 0.25,
            decoration: shadowBoxDecoration,
            padding: const EdgeInsets.all(GapSize.xxSmall),
            child: Row(
              children: [
                Expanded(flex: 4, child: Container()),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: GapSize.xSmall),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Row(
                            children: [
                              Text(
                                '${store?.stroreName}',
                                style: const TextStyle(
                                  fontFamily: "NanumB",
                                  fontSize: FontSize.large,
                                  height: 1.7,
                                ),
                              ),
                              controller.pinned.value
                                  ? IconButton(
                                      onPressed: () {
                                        controller.home.removePin();
                                      },
                                      icon: const Icon(Icons.push_pin),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        controller.home.setPin();
                                      },
                                      icon: const Icon(Icons.push_pin_outlined),
                                    ),
                            ],
                          ),
                        ),
                        Text(
                          '주소 : ${store?.storeAddr}',
                          style: regularNanumTextStyle,
                        ),
                        Text(
                          '전화번호 : ${store?.storePhone}',
                          style: regularNanumTextStyle,
                        ),
                        const Text(
                          '이용 시간',
                          style: regularNanumTextStyle,
                        ),
                        Text(
                          '평일 : ${store?.storeOpentime}',
                          style: regularNanumTextStyle,
                        ),
                        Text(
                          '주말 : ${store?.storeOpentime}',
                          style: regularNanumTextStyle,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
