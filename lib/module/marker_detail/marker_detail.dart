import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:like_button/like_button.dart';
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: GapSize.xxxSmall),
                      child: Row(children: [
                        Expanded(
                          flex: 7,
                          child: Text(
                            '${store?.storeName}',
                            style: const TextStyle(
                              fontFamily: "NotoB",
                              overflow: TextOverflow.ellipsis,
                              fontSize: FontSize.large,
                              height: 1.3,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Obx(
                              () =>
                              LikeButton(
                                circleColor: const CircleColor(
                                    start: Color(0xff00ddff),
                                    end: Color(0xff0099cc)),
                                bubblesColor: const BubblesColor(
                                  dotPrimaryColor: Color(0xff33b5e5),
                                  dotSecondaryColor: Color(0xff0099cc),
                                ),
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.push_pin,
                                    color: isLiked ? Colors.redAccent : Colors
                                        .grey,
                                    size: 23,
                                  );
                                },
                                isLiked: controller.detailPinState.value,
                                onTap: (bool isLiked) async {
                                  if (isLiked) {
                                    controller.removePin();
                                  } else {
                                    controller.setPin();
                                  }
                                  return controller.detailPinState.value;
                                },
                              ),
                        ),
                        Obx(
                              () =>
                              LikeButton(
                                circleColor: const CircleColor(
                                    start: Color(0xff00ddff),
                                    end: Color(0xff0099cc)),
                                bubblesColor: const BubblesColor(
                                  dotPrimaryColor: Color(0xff33b5e5),
                                  dotSecondaryColor: Color(0xff0099cc),
                                ),
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.stars,
                                    color:
                                    isLiked ? Colors.yellow[600] : Colors.grey,
                                    size: 25,
                                  );
                                },
                                isLiked: controller.detailClientStoreBookMark
                                    .value,
                                onTap: (bool isLiked) async {
                                  controller.updateBookMark(store);
                                  return !isLiked;
                                },
                              ),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: GapSize.xSmall,
                    ),
                    SizedBox(
                      height: 180,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(RadiusSize.large)),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(RadiusSize.large)),
                              child: store!.imageUrl == null
                                  ? Image.asset(
                                  'asset/image/logo/splash_logo.png')
                                  : Image.network(
                                store!.imageUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: GapSize.xSmall),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '업체 주소',
                                    style: TextStyle(
                                        fontSize: FontSize.small,
                                        fontFamily: "NotoB",
                                        height: 1.6,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: GapSize.xxxSmall,
                                  ),
                                  Text(
                                    '${store?.storeAddr}',
                                    style: const TextStyle(
                                        fontSize: FontSize.xSmall,
                                        fontFamily: "NotoR",
                                        height: 1.6,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                  const SizedBox(
                                    height: GapSize.xxxSmall,
                                  ),
                                  const Text(
                                    '업체 전화번호',
                                    style: TextStyle(
                                        fontSize: FontSize.small,
                                        fontFamily: "NotoB",
                                        height: 1.6,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: GapSize.xxxSmall,
                                  ),
                                  Text(
                                    '${store?.storePhone}',
                                    style: const TextStyle(
                                        fontSize: FontSize.xSmall,
                                        fontFamily: "NotoR",
                                        height: 1.6,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                  const SizedBox(
                                    height: GapSize.xxxSmall,
                                  ),
                                  const Text(
                                    '업체 사이트',
                                    style: TextStyle(
                                        fontSize: FontSize.small,
                                        fontFamily: "NotoB",
                                        height: 1.6,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: GapSize.xxxSmall,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      final Uri url =
                                      Uri.parse(store!.storeUrl!);
                                      if (Platform.isAndroid) {
                                        InAppBrowser.openWithSystemBrowser(
                                            url: url);
                                      } else if (Platform.isIOS) {
                                        ChromeSafariBrowser().open(
                                          url: url,
                                        );
                                      }
                                    },
                                    child: Text(
                                      '${store?.storeUrl}',
                                      style: const TextStyle(
                                          fontSize: FontSize.xSmall,
                                          fontFamily: "NotoR",
                                          height: 1.6,
                                          color: Colors.blue,
                                        overflow: TextOverflow.clip
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
