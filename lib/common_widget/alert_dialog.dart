import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/style.dart';

///AlertDialog를 불러오는 공통 위젯
class CommonDialog extends StatelessWidget {
  CommonDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.positiveFunc,
  }) : super(key: key);
  final title;
  final content;
  Function positiveFunc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "$title",
        style: boldNanumTextStyle,
      ),
      content: Text("$content", style: regularEllipsisNanumTextStyle),
      actions: [
        TextButton(
          child: const Text("취소"),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: const Text("확인"),
          onPressed: () {
            positiveFunc();
            Get.back();
          },
        )
      ],
    );
  }
}
