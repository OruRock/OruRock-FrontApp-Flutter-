import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:oru_rock/common_widget/ImageViewer.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/app/app_controller.dart';

class HomeFavorites extends GetView<AppController> {
  const HomeFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.symmetric(
            horizontal: GapSize.medium, vertical: GapSize.small),
        child: Text(
          '즐겨찾는 암장',
          style: TextStyle(fontSize: FontSize.large, fontFamily: "NotoB"),
        ),
      ),
      Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.clientStoreBookMark.value.isNotEmpty ? ListView.builder(
                padding: const EdgeInsets.symmetric(
                    vertical: GapSize.xxxSmall),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.clientStoreBookMark.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: GapSize.medium, vertical: GapSize.xxxSmall),
                    child: Container(
                      decoration: shadowBoxDecoration,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.goMapToSelectedStoreAtBookMark(index);
                            },
                            child: ListTile(
                              leading: ImageViewer(
                                imageUrl: controller
                                    .clientStoreBookMark[index].imageUrl,
                                width: 50,
                                height: 50,
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: GapSize.xxSmall),
                                child: Text(controller
                                    .clientStoreBookMark[index].storeName!),
                              ),
                              subtitle: Text(controller
                                  .clientStoreBookMark[index].storePhone!),
                              trailing: SizedBox(
                                width: 50,
                                height: 50,
                                child: LikeButton(
                                  circleColor: const CircleColor(
                                      start: Color(0xFFFFEE58),
                                      end: Color(0xFFF9A825)),
                                  bubblesColor: const BubblesColor(
                                    dotPrimaryColor: Color(0xFFFBC02D),
                                    dotSecondaryColor: Color(0xFFF9A825),
                                  ),
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      isLiked ? Icons.star : Icons.star_border_outlined,
                                      color:
                                      isLiked ? Colors.yellow[600] : Colors.grey,
                                      size: 30,
                                    );
                                  },
                                  isLiked: true,
                                  onTap: (bool isLiked) async {
                                    controller.detailButtonState[1].value =
                                        true;
                                    controller.updateBookMark(controller
                                        .clientStoreBookMark.value[index]);
                                    return !isLiked;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
        : Center(
            child: FractionallySizedBox(
              widthFactor: 0.4,
              child: Image.asset("asset/image/icon/empty_folder.png")
            )
        ),
      ),
    ]);
  }
}
