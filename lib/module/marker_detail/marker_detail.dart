import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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
                      padding:
                          const EdgeInsets.symmetric(horizontal: GapSize.small),
                      child: Row(
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
                            Expanded(child: Container(),),
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
                                    Icons.pin_drop,
                                    color: isLiked ? Colors.black : Colors.grey,
                                    size: 25,
                                  );
                                },
                                isLiked: controller.detailPinState.value,
                                onTap: (bool isLiked) async {
                                  if (isLiked) {
                                    controller.removePin();
                                  } else {
                                    controller.setPin();
                                  }
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
                                    Icons.favorite,
                                    color: isLiked
                                        ? Colors.pinkAccent
                                        : Colors.grey,
                                    size: 25,
                                  );
                                },
                                isLiked:
                                    controller.detailClientStoreBookMark.value,
                                onTap: (bool isLiked) async {
                                  controller.updateBookMark(store);
                                  return !isLiked;
                                },
                              ),
                            ),
                          ]),
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
                        '상세 정보 보러가기 ',
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
