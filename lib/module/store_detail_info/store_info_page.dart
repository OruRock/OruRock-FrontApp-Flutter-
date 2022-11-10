import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/model/store_model.dart' as storeModel;
import 'package:oru_rock/module/store_detail_info/fragment/review.dart';
import 'package:oru_rock/module/store_detail_info/fragment/store_info.dart';
import 'package:oru_rock/module/store_detail_info/store_info_controller.dart';
import 'package:toggle_switch/toggle_switch.dart';

class StoreInfo extends GetView<StoreInfoController> {
  final storeModel.StoreModel? store = Get.arguments[0];

  StoreInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(
            '${store?.storeName}',
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
            : Stack(
                children: [
                  SizedBox(
                    height: Get.height * 0.25,
                    child: ImageSlideshow(
                      indicatorColor: Colors.black,
                      indicatorBackgroundColor: Colors.grey,
                      width: Get.width,
                      children: controller.detailModel.value!.image!.isEmpty
                          ? [Image.asset('asset/image/logo/splash_logo.png')]
                          : List.generate(
                              controller.detailModel.value!.image!.length,
                              (index) {
                              return Image.network(
                                controller
                                    .detailModel.value!.image![index].imageUrl!,
                                fit: BoxFit.fill,
                              );
                            }),
                    ),
                  ),
                  Column(
                    children: [
                      IgnorePointer(
                        child: AnimatedContainer(
                          color: Colors.transparent,
                          curve: Curves.ease,
                          height: controller.imageSliderHeight.value,
                          duration: const Duration(milliseconds: 600),
                        ),
                      ),
                      Expanded(
                        child: Container(
                        padding: EdgeInsets.fromLTRB(WidthWithRatio.small,
                            GapSize.xSmall, WidthWithRatio.small, 0),
                        color: Colors.grey[100],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: HeightWithRatio.xxxxSmall,
                            ),
                            Center(
                              child: ToggleSwitch(
                                minWidth: Get.width / 3,
                                minHeight: 40.0,
                                initialLabelIndex: controller.selectedInfo.value,
                                cornerRadius: 12.0,
                                inactiveBgColor: Colors.grey,
                                activeBgColor: const [Colors.black],
                                totalSwitches: 2,
                                labels: const ['암장 정보', '리뷰'],
                                customTextStyles: const [
                                  TextStyle(
                                      fontSize: 16,
                                      fontFamily: "NotoM",
                                      color: Colors.white),
                                  TextStyle(
                                      fontSize: 16,
                                      fontFamily: "NotoM",
                                      color: Colors.white)
                                ],
                                animate: true,
                                curve: Curves.easeIn,
                                animationDuration: 200,
                                onToggle: (index) {
                                  controller.selectedInfo.value = index!;
                                  controller.imageSliderHeight.value =
                                      controller.imageHeight[index];
                                },
                              ),
                            ),
                            controller.selectedInfo.value == 0
                                ? StoreInfoFragment(store: store)
                                : ReviewFragment(store: store),
                          ],
                        ),
                    ),
                      )],
                  )
                ],
              )),
      ),
    );
  }
}
