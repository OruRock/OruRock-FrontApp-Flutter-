import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:oru_rock/common_widget/ImageViewer.dart';
import 'package:oru_rock/common_widget/banner_ad.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/app/app_controller.dart';

class Search extends GetView<AppController> {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
          title: const Text(
            '검색',
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchTextField(),
            Obx(
              () => Expanded(
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                        children: [
                          buildSearchList(),
                          buildLoadingDataDialog(),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildLoadingDataDialog() {
    return Visibility(
      visible: controller.isGetMoreData.value,
      child: Center(
        child: Container(
            width: Get.width * 0.8,
            height: Get.height * 0.2,
            color: Colors.black.withOpacity(0.5),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(
                  height: GapSize.small,
                ),
                Text(
                  '데이터를 로딩 중 입니다.',
                  style: TextStyle(
                      fontFamily: "NotoB",
                      fontSize: FontSize.medium,
                      color: Colors.white),
                )
              ],
            ))),
      ),
    );
  }

  buildSearchList() {
    return AnimationLimiter(
      child: ListView.builder(
          controller: controller.searchScrollController,
          itemCount: controller.searchStores.length,
          itemBuilder: (BuildContext context, int index) {
            if (index % 10 == 0 && index >= 10) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: GapSize.medium),
                child: BannerAdWidget(),
              );
            }
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      controller.goMapToSelectedStore(index);
                    },
                    child: _buildListCard(index),
                  ),
                ),
              ),
            );
          }),
    );
  }

  _buildSearchTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          GapSize.small, GapSize.small, GapSize.small, 0),
      child: TextField(
        controller: controller.searchText,
        decoration: InputDecoration(
            filled: false,
            suffixIcon: IconButton(
              onPressed: () {
                controller.search();
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            hintText: "암장을 검색해 보세요!",
            hintStyle: const TextStyle(
                fontSize: FontSize.large,
                color: Colors.grey,
                fontFamily: "NotoR"),
            enabledBorder:
                const OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
            focusedBorder:
                const OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
            contentPadding: const EdgeInsets.symmetric(
                vertical: GapSize.small, horizontal: GapSize.small)),
        style: const TextStyle(fontSize: FontSize.large, fontFamily: "NotoR"),
      ),
    );
  }

  _buildListCard(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: GapSize.xxSmall, horizontal: GapSize.small),
      child: Container(
        height:
            HeightWithRatio.large + WidthWithRatio.xSmall + GapSize.small * 3,
        decoration: shadowBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(GapSize.small),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ImageViewer(
                    imageUrl: controller.searchStores[index].imageUrl,
                    width: HeightWithRatio.large,
                    height: HeightWithRatio.large,
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    width: HeightWithRatio.large,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.car_crash_sharp,
                          size: WidthWithRatio.xSmall,
                        ),
                        Icon(Icons.shower, size: WidthWithRatio.xSmall),
                        Icon(Icons.wc, size: WidthWithRatio.xSmall),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: GapSize.small,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${controller.searchStores[index].storeName}",
                            style: const TextStyle(
                                fontSize: FontSize.medium,
                                fontFamily: "NotoB",
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: GapSize.xxSmall,
                    ),
                    AutoSizeText(
                      "${controller.searchStores[index].storeAddr}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: FontSize.small,
                      style: const TextStyle(
                          fontSize: FontSize.small,
                          fontFamily: "NotoR",
                          color: Colors.black87),
                    ),
                    const SizedBox(
                      height: GapSize.xxSmall,
                    ),
                    AutoSizeText(
                      "${controller.searchStores[index].storePhone}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: FontSize.small,
                      style: const TextStyle(
                          fontSize: FontSize.small,
                          fontFamily: "NotoR",
                          color: Colors.black87),
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
