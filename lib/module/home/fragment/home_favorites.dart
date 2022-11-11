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
            : ListView.builder(
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
                              title: Text(controller
                                  .clientStoreBookMark[index].storeName!),
                              subtitle: Text(controller
                                  .clientStoreBookMark[index].storePhone!),
                              trailing: SizedBox(
                                width: 50,
                                height: 50,
                                child: LikeButton(
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
                                  isLiked: true,
                                  onTap: (bool isLiked) async {
                                    controller.detailClientStoreBookMark.value =
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
              ),
      ),
    ]);
  }
}
