import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/model/store_model.dart' as storeModel;
import 'package:oru_rock/module/app/app_controller.dart';

import '../../routes.dart';

class MarkerDetail extends GetView<AppController> {
  final storeModel.StoreModel? store;

  const MarkerDetail({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.storeInfo, arguments: [store]);
        },
        child: Container(
          height: 275,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(RadiusSize.large)),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
                child: Center(
                  child: Icon(Icons.horizontal_rule),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: GapSize.small),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: GapSize.small),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${store?.storeName}',
                            style: const TextStyle(
                              fontFamily: "NotoB",
                              overflow: TextOverflow.ellipsis,
                              fontSize: FontSize.large,
                              height: 1.3,
                            ),
                          ),
                          Obx(
                            () => controller.detailPinState.value
                                ? IconButton(
                                    padding: const EdgeInsets.only(
                                        bottom: GapSize.xxxSmall),
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      controller.removePin();
                                    },
                                    icon: const Icon(
                                      Icons.push_pin,
                                      size: 25,
                                    ),
                                  )
                                : IconButton(
                                    padding: const EdgeInsets.only(
                                        bottom: GapSize.xxxSmall),
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      controller.setPin();
                                    },
                                    icon: const Icon(
                                      Icons.push_pin_outlined,
                                      size: 25,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: GapSize.xxSmall),
                      child: Divider(
                        height: 1.0,
                        thickness: 1.0,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: GapSize.xxSmall),
                            child: store!.imageUrl == null
                                ? Image.asset(
                                    'asset/image/logo/splash_logo.png')
                                : Image.network(
                                    store!.imageUrl!,
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: GapSize.xSmall),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '?????? : ${store?.storeAddr}',
                                  style: regularNanumTextStyle,
                                ),
                                Text(
                                  '???????????? : ${store?.storePhone}',
                                  style: regularNanumTextStyle,
                                ),
                                const Text(
                                  '?????? ??????',
                                  style: regularNanumTextStyle,
                                ),
                                Text(
                                  '?????? : ${store?.storeOpentime}',
                                  style: regularNanumTextStyle,
                                ),
                                Text(
                                  '?????? : ${store?.storeOpentime}',
                                  style: regularNanumTextStyle,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: GapSize.small),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      AutoSizeText(
                        '?????? ?????? ???????????? ',
                        style: TextStyle(color: Colors.blue),
                        minFontSize: FontSize.xSmall,
                        maxFontSize: FontSize.medium,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: GapSize.small,
              )
            ],
          ),
        ),
      ),
    );
  }
}
