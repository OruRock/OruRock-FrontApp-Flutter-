import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/common_widget/alert_dialog.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/model/store_detail_model.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';

class MyReviewList extends GetView<SettingController> {
  const MyReviewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My 리뷰',
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: GapSize.xxxSmall),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.myReviewList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GapSize.medium, vertical: GapSize.xxxSmall),
                      child: Container(
                        decoration: shadowBoxDecoration,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: ListTile(
                                minVerticalPadding: GapSize.xSmall,
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: GapSize.xxSmall),
                                  child: Text(controller
                                    .myReviewList[index].storeName!),
                                ),
                                subtitle: Text(controller
                                    .myReviewList[index].comment!),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _buildRemoveDialog(
                                        controller.myReviewList.value[index]);
                                    },
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
      ),
    );
  }

  _buildRemoveDialog(Comment comment) {
    Get.dialog(CommonDialog(
        title: "경고",
        content: "선택한 리뷰를 정말 삭제하시겠습니까?",
        positiveFunc: () async {
          await controller.removeCommentAtMyReview(comment);
        }));
  }
}
