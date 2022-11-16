import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/model/notice_detail_model.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';

class NoticeDetail extends GetView<SettingController> {
  final NoticeDetailModel? noticeDetailModel;

  const NoticeDetail({Key? key, required this.noticeDetailModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '공지사항 상세',
          ),
        ),
        body: Center(
          child: Container(
              width: Get.width * 0.9,
              height: Get.height * 0.8,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(
                        0, 0), // changes position of shadow
                  )
                ],
                color: Colors.white.withOpacity(0.7),
                borderRadius: const BorderRadius.all(
                    Radius.circular(RadiusSize.large)
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: GapSize.medium, horizontal: GapSize.medium),
                    child: Text(noticeDetailModel!.title!, style: boldNanumTextStyle,),
                  ),
                  const Divider(
                    height: 1.0,
                    thickness: 1.0,
                    indent: 10.0,
                    endIndent: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(vertical: GapSize.medium, horizontal: GapSize.medium),
                      child: Text(noticeDetailModel!.content!, style: regularClipNanumTextStyle,),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.symmetric(vertical: GapSize.medium, horizontal: GapSize.medium),
                    child: Text(
                        DateFormat("yyyy-MM-dd HH:mm:ss")
                            .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                            .parse(noticeDetailModel!.createDate!)),
                        style: regularEllipsisNanumGreyTextStyle),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}
