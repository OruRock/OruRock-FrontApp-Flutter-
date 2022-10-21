import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/model/store_model.dart' as storeModel;
import 'package:oru_rock/module/store_detail_info/fragment/review.dart';
import 'package:oru_rock/module/store_detail_info/fragment/store_info.dart';
import 'package:oru_rock/module/store_detail_info/store_info_controller.dart';

class StoreInfo extends GetView<StoreInfoController> {
  final storeModel.StoreModel? store = Get.arguments[0];

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
                fontFamily: "NotoB",
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
        body: Obx(() => controller.isLoading.value == false
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    curve: Curves.ease,
                  height: controller.imageSliderHeight.value,
                            duration: const Duration(milliseconds: 800),
                            child: ImageSlideshow(
                                width: Get.width,
                                children:
                                    controller.detailModel.value!.image!.isEmpty
                                        ? [
                                            Image.asset(
                                                'asset/image/logo/splash_logo.png')
                                          ]
                                        : List.generate(
                                            controller.detailModel.value!.image!
                                                .length, (index) {
                                            return Image.network(controller
                                                .detailModel
                                                .value!
                                                .image![index]
                                                .imageUrl!);
                                          }),
                              ),
                          ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: WidthWithRatio.small, vertical: GapSize.xSmall),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: HeightWithRatio.xxxxSmall,
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              child: FlutterToggleTab(
                                height: Get.height / 25,
                                width: Get.width / 6,
                                isScroll: false,
                                borderRadius: 10,
                                labels: controller.toggleList,
                                selectedLabelIndex: (index) {
                                  controller.selectedInfo.value = index;
                                  controller.imageSliderHeight.value = controller.imageHeight[index];
                                },
                                selectedTextStyle: selectedToggleTextStyle,
                                unSelectedTextStyle: unSelectedToggleTextStyle,
                                unSelectedBackgroundColors: [Colors.white],
                                selectedBackgroundColors: [Colors.black],
                                selectedIndex: controller.selectedInfo.value,
                              ),
                            ),
                          ),
                          controller.selectedInfo.value == 0
                              ? StoreInfoFragment(store: store)
                              : ReviewFragment(store: store),
                        ],
                      ),
                    ),
                  )
                ],
              )),
      ),
    );
  }
}
