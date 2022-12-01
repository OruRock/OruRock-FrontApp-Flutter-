import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';

///AlertDialog를 불러오는 공통 위젯
class ReportDialog extends StatelessWidget {
  ReportDialog({
    Key? key,
    required this.title,
    required this.reportFunc,
  }) : super(key: key);
  final title;
  Function(String) reportFunc;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return AlertDialog(
      titlePadding: const EdgeInsets.symmetric(horizontal: GapSize.medium, vertical: GapSize.small),
      contentPadding: const EdgeInsets.symmetric(horizontal: GapSize.small, vertical: GapSize.xxxSmall),
      actionsPadding: const EdgeInsets.symmetric(horizontal: GapSize.xSmall),
      buttonPadding: EdgeInsets.zero,
      title: Text(
        "$title",
        style: boldNanumTextStyle,
      ),
      content: TextFormField(
        maxLines: null,
        minLines: 12,
        style: const TextStyle(fontSize: 12, fontFamily: "NotoR"),
        decoration: InputDecoration(
          hintText: '신고 사유를 입력해주세요.',
          hintStyle: const TextStyle(fontSize: 12, fontFamily: "NotoR"),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(RadiusSize.medium),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(RadiusSize.medium),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(RadiusSize.medium),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(RadiusSize.medium),
            borderSide: const BorderSide(color: Colors.black12),
          ),
        ),
        keyboardType: TextInputType.multiline,
        controller: textEditingController,
      ),
      actions: [
        TextButton(
          child: const Text("취소", style: TextStyle(color: Colors.grey), textAlign: TextAlign.end,),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: const Text("확인",textAlign: TextAlign.end,),
          onPressed: () {
            reportFunc(textEditingController.text);
            Get.back();
          },
        )
      ],
    );
  }
}
