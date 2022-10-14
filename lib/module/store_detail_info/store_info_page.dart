import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/model/store_detail_model.dart' as detailModel;
import 'package:oru_rock/model/store_model.dart' as storeModel;
import 'package:oru_rock/module/store_detail_info/store_info_controller.dart';

class StoreInfo extends GetView<StoreInfoController> {
  final storeModel.StoreModel? store = Get.arguments[0];
  final detailModel.StoreReviewModel? review = Get.arguments[1];

  StoreInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${store?.stroreName}',
            style: const TextStyle(
                fontFamily: "NanumB",
                fontSize: FontSize.large,
                height: 1.7,
                color: Colors.black),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageSlideshow(
                width: Get.width,
                height: HeightWithRatio.xxxLarge,
                children: review!.image!.isEmpty
                    ? [Image.asset('asset/image/logo/splash_logo.png')]
                    : List.generate(review!.image!.length, (index) {
                        return Image.network(review!.image![index].imageUrl!);
                      }),
              ),
              const Divider(color: Colors.grey),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: WidthWithRatio.small),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: HeightWithRatio.xxSmall,
                      ),
                      Center(
                        child: FlutterToggleTab(
                          height: Get.height /20,
                          width: Get.width/5,
                          isScroll: false,
                          borderRadius: 10,
                          labels: controller.toggleList,
                          selectedLabelIndex: (index) {
                            controller.selectedInfo.value = index;
                          },
                          selectedTextStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          unSelectedTextStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.normal),
                          selectedIndex: controller.selectedInfo.value,
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            SizedBox(
                              height: HeightWithRatio.xxxxSmall,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'asset/image/icon/address_icon.png',
                                  height: WidthWithRatio.small,
                                ),
                                const SizedBox(
                                  width: GapSize.xxSmall,
                                ),
                                Text(
                                  '${store?.storeAddr}',
                                  style: regularNanumDetailPageTextStyle,
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              height: HeightWithRatio.xxSmall,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'asset/image/icon/phone_icon.png',
                                  height: WidthWithRatio.small,
                                ),
                                const SizedBox(
                                  width: GapSize.xxSmall,
                                ),
                                Text(
                                  '${store?.storePhone}',
                                  style: regularNanumDetailPageTextStyle,
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              height: HeightWithRatio.xxSmall,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'asset/image/icon/timer_icon.png',
                                      height: WidthWithRatio.small,
                                    ),
                                    const SizedBox(
                                      width: GapSize.xxSmall,
                                    ),
                                    const Text(
                                      '이용 시간',
                                      style: boldNanumTextStyle,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: GapSize.xxSmall,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: WidthWithRatio.small),
                                  child: Text(
                                    '평일 : ${store?.storeOpentime}',
                                    style: regularNanumTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: WidthWithRatio.small),
                                  child: Text(
                                    '주말 : ${store?.storeOpentime}',
                                    style: regularNanumTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              height: HeightWithRatio.xxSmall,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'asset/image/icon/description_icon.png',
                                      height: WidthWithRatio.small,
                                    ),
                                    const SizedBox(
                                      width: GapSize.xxSmall,
                                    ),
                                    const Text(
                                      '설명',
                                      style: boldNanumTextStyle,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: GapSize.xxSmall,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: WidthWithRatio.small),
                                  child: Text(
                                    '${store?.storeDescription}',
                                    style: regularNanumTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              height: HeightWithRatio.xxSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
