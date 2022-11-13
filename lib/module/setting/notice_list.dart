import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/setting/notice_detail.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';
import 'package:intl/intl.dart';

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
                  padding: const EdgeInsets.symmetric(
                      vertical: GapSize.xxxSmall),
                  shrinkWrap: true,
                  itemCount: controller.noticeList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GapSize.medium, vertical: GapSize.xxxSmall),
                      child: Container(
                        decoration: shadowBoxDecoration,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Get.to(NoticeDetail(
                                  noticeDetailModel: await controller.getNoticeDetail(
                                      controller.noticeList[index].noticeId!),
                                ));
                              },
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: GapSize.xxSmall),
                                  child: Text(controller
                                      .noticeList[index].title!),
                                ),
                                subtitle: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    DateFormat("yyyy-MM-dd HH:mm:ss")
                                        .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                                        .parse(controller
                                    .noticeList[index].createDate!))),
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
}
