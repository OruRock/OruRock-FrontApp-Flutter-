import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/module/setting/notice_detail.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';

class NoticeList extends GetView<SettingController> {
  const NoticeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '공지사항',
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.noticeList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Get.to(NoticeDetail(
                              noticeDetailModel:
                                  await controller.getNoticeDetail(
                                      controller.noticeList[index].noticeId!),
                            ));
                          },
                          child: ListTile(
                            title: Text(controller.noticeList[index].title!),
                            subtitle:
                                Text(controller.noticeList[index].createDate!),
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
}
