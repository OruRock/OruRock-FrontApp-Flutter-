import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(noticeDetailModel!.title!, style: boldNanumTextStyle,),
            const SizedBox(
              height: GapSize.large,
            ),
            Text(noticeDetailModel!.content!, style: regularClipNanumTextStyle,),
            const SizedBox(
              height: GapSize.large,
            ),
            Text('${noticeDetailModel!.createDate}', style: regularEllipsisNanumTextStyle,),
          ],
        )
      ),
    );
  }
}
