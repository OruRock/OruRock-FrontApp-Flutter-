import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:oru_rock/common_widget/alert_dialog.dart';
import 'package:oru_rock/constant/style/size.dart';
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
            style: TextStyle(
                fontFamily: "NoteB",
                fontSize: FontSize.xLarge,
                height: 1,
                color: Colors.black),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.myReviewList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: ListTile(
                            title: Text(
                                controller.myReviewList[index].userNickname!),
                            subtitle:
                                Text(controller.myReviewList[index].comment!),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _buildRemoveDialog(
                                    controller.myReviewList.value[index]);
                              },
                            ),
                          ),
                        ),
                      ],
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
