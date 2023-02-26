import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/model/notice_detail_model.dart';
import 'package:oru_rock/module/setting/fragment/notice_detail.dart';
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
                    var isExpanded = false.obs;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GapSize.medium, vertical: GapSize.xxxSmall),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: GapSize.xSmall),
                        decoration: shadowBoxDecoration,
                        child: Column(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: Obx(() => ExpansionTile(
                                onExpansionChanged: (expand) {
                                  isExpanded.value = expand;
                                },
                                trailing: isExpanded.value
                                    ? const Icon(Icons.keyboard_arrow_up, color: Colors.black)
                                    : const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                                tilePadding: EdgeInsets.zero,
                                title: Text(controller
                                    .noticeList[index].title!,
                                  style: isExpanded.value
                                      ? const TextStyle(fontFamily: "NotoB", color: Colors.black)
                                      : const TextStyle(fontFamily: "NotoR", color: Colors.black),
                                ),
                                subtitle: Text(DateFormat("yyyy-MM-dd HH:mm:ss")
                                    .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                                    .parse(controller
                                    .noticeList[index].createDate!),),
                                  style: isExpanded.value
                                      ? const TextStyle(fontFamily: "NotoB", color: Colors.black)
                                      : const TextStyle(fontFamily: "NotoR", color: Colors.black),
                                ),
                                children:
                                <Widget>[
                                  const Divider(thickness: 1, color: Colors.black12),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: GapSize.medium),
                                    child: FutureBuilder<NoticeDetailModel?>(
                                      future: controller.getNoticeDetail(controller.noticeList[index].noticeId!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  snapshot.data!.content!));
                                        }
                                        return const Text("error");
                                      },
                                    ),
                                  ),
                                ],
                              )),
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
