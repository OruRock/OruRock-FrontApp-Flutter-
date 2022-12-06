import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:like_button/like_button.dart';
import 'package:oru_rock/common_widget/ImageViewer.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/model/store_model.dart' as storeModel;
import 'package:oru_rock/module/app/app_controller.dart';
import 'package:url_launcher/url_launcher.dart';

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
          height: 290,
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
                          () => LikeButton(
                            circleColor: const CircleColor(
                                start: Color(0xfff0ddff),
                                end: Color(0xffffb5e5)),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: Color(0xffffb5e5),
                              dotSecondaryColor: Color(0xffff99cc),
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                isLiked ? Icons.push_pin_rounded : Icons.push_pin_outlined,
                                color: isLiked ? Colors.redAccent : Colors.grey,
                                size: 20,
                              );
                            },
                            isLiked: controller.detailButtonState[0].value,
                            onTap: (bool isLiked) async {
                              if (isLiked) {
                                controller.removePin();
                              } else {
                                controller.setPin();
                              }
                              return controller.detailButtonState[0].value;
                            },
                          ),
                        ),
                        Obx(
                          () => LikeButton(
                            circleColor: const CircleColor(
                                start: Color(0xff00ddff),
                                end: Color(0xff0099cc)),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: Color(0xff33b5e5),
                              dotSecondaryColor: Color(0xff0099cc),
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                isLiked ? Icons.stars : Icons.star_border_outlined,
                                color:
                                    isLiked ? Colors.yellow[600] : Colors.grey,
                                size: 20,
                              );
                            },
                            isLiked: controller.detailButtonState[1].value,
                            onTap: (bool isLiked) async {
                              controller.updateBookMark(store);
                              return !isLiked;
                            },
                          ),
                        ),
                        Obx(
                          () => LikeButton(
                            circleColor: const CircleColor(
                                start: Color(0xff00ddff),
                                end: Color(0xff0099cc)),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: Color(0xff33b5e5),
                              dotSecondaryColor: Color(0xff0099cc),
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                                color: isLiked ? Colors.blue[600] : Colors.grey,
                                size: 20,
                              );
                            },
                            isLiked: controller.detailButtonState[2].value,
                            onTap: (bool isLiked) async {
                              controller.updateLikedStore(store);
                              return !isLiked;
                            },
                            likeCount: controller.likeStoreCount.value,
                            countBuilder:
                                (int? count, bool isLiked, String text) {
                              var color = isLiked ? Colors.black : Colors.black;
                              Widget result;
                              if (count == 0) {
                                result = Text(
                                  "0",
                                  style: TextStyle(
                                      color: color,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                );
                              } else {
                                result = Text(
                                  text,
                                  style: TextStyle(
                                      color: color,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                              return result;
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
                          ImageViewer(
                            imageUrl: store!.imageUrl,
                            width: 150,
                            height: 150,
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
                                        overflow: TextOverflow.ellipsis),
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
                                  InkWell(
                                    onTap: () => launchUrl(
                                        Uri.parse('tel:${store?.storePhone}')
                                    ),
                                    child: Text(
                                      '${store?.storePhone}',
                                      style: const TextStyle(
                                          fontSize: FontSize.xSmall,
                                          fontFamily: "NotoR",
                                          height: 1.6,
                                          color: Colors.blue,
                                          overflow: TextOverflow.ellipsis),
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
                                          overflow: TextOverflow.clip),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: OutlinedButton(
                          onPressed: () {
                        controller.map.linkNaverMapNavigate(LatLng(store!.storeLat!, store!.storeLng!), store!.storeName!);
                      }, child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: GapSize.xxxSmall),
                        child: Text('길찾기', style: TextStyle(color: Colors.green, fontFamily: "NotoM"),),
                      )),
                    )
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
