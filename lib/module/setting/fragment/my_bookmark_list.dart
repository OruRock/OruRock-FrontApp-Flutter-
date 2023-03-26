import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:like_button/like_button.dart';
import 'package:oru_rock/common_widget/ImageViewer.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class MyBookmarkList extends GetView<SettingController> {
  const MyBookmarkList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My 즐겨찾기',
          ),
        ),
        body: Obx(
          () => ListView.builder(
            padding: const EdgeInsets.symmetric(
                vertical: GapSize.xxxSmall),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller
                .app.clientStoreBookMark.value.length,
            itemBuilder: (BuildContext context, int index) {
              return buildBookmarkList(index);
            },
          ),
        ),
      ),
    );
  }

  Padding buildBookmarkList(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: GapSize.medium, vertical: GapSize.xxxSmall),
      child: Container(
        decoration: shadowBoxDecoration,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                controller.app.goMapToSelectedStoreAtBookMark(index);
                },
              child: ListTile(
                leading: ImageViewer(
                  imageUrl: controller
                      .app.clientStoreBookMark[index].imageUrl,
                  width: 50,
                  height: 50,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(
                      bottom: GapSize.xxSmall),
                  child: Text(controller
                      .app.clientStoreBookMark[index].storeName!),
                ),
                subtitle: InkWell(
                  onTap: () => launchUrl(
                      Uri.parse('tel:${controller
                          .app.clientStoreBookMark[index].storePhone!}')
                  ),
                  child: Text(
                    controller
                      .app.clientStoreBookMark[index].storePhone!,
                    style: regularEllipsisNanumTextStyle.apply(color: Colors.blue),

                  ),
                ),
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
                      controller.app.detailButtonState[1].value =
                          true;
                      controller.app.updateBookMark(controller
                          .app.clientStoreBookMark.value[index]);
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
  }
}
