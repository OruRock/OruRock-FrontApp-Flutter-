import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/model/store_model.dart' as storeModel;
import 'package:oru_rock/module/home/home_controller.dart';

import '../../routes.dart';

class MarkerDetail extends GetView<HomeController> {
  final storeModel.StoreModel? store;

  const MarkerDetail({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HeightWithRatio.xxxLarge,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(RadiusSize.large)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: HeightWithRatio.xxSmall,
            child: const Center(
              child: Icon(Icons.horizontal_rule),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: GapSize.xxSmall),
            child: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(GapSize.small),
                      child: store!.image!.isEmpty
                          ? Image.asset('asset/image/logo/splash_logo.png')
                          : Image.network(
                              store!.image![0].imageUrl!,
                            ),
                    )),
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
                              controller.detailPinState.value
                                  ? IconButton(
                                      onPressed: () {
                                        controller.removePin();
                                      },
                                      icon: const Icon(Icons.push_pin),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        controller.setPin();
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
          Expanded(child: Container()),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.storeInfo, arguments: [store]);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: GapSize.small),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      '상세 정보 보러가기 ',
                      style: TextStyle(color: Colors.blue),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: GapSize.medium,
          )
        ],
      ),
    );
  }
}
