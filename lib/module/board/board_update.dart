import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:oru_rock/common_widget/custom_text_form_field.dart';
import 'package:oru_rock/common_widget/custom_textarea.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/helper/nickname_checker.dart';
import 'package:oru_rock/module/board/board_controller.dart';

class BoardUpdatePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final BoardController boardController = Get.find();
    _title.text = boardController.board.value?.subject ?? '';
    _content.text = boardController.board.value?.content ?? '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('글쓰기'),
        actions: [
          TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await boardController.writeBoard(
                      boardController.board.value?.boardId ?? -1,
                      _title.text,
                      _content.text);
                  boardController.board.value?.boardId != null
                      ? Fluttertoast.showToast(msg: '편집완료우.')
                      : Fluttertoast.showToast(msg: '등록완료우.');
                  Get.back();
                }
              },
              child: Text(
                boardController.board.value?.boardId != null ? "수정" : "등록",
                style: TextStyle(color: Colors.indigoAccent),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(GapSize.medium),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              CustomTextFormField(
                controller: _title,
                hint: "제목을 입력해주세요.",
                funValidator: validateTitle(),
              ),
              SizedBox(
                height: GapSize.xxSmall,
              ),
              CustomTextArea(
                controller: _content,
                hint: "내용을 입력해주세요. (10글자이상)",
                funValidator: validateContent(),
              ),
              // homepage -> detailpage -> detailpage
              // CustomElevatedButton(
              //   text:
              //       "글 ${boardController.board.value.board_id != null ? "수정" : "등록"}하기",
              //   funPageRoute: () async {
              //     if (_formKey.currentState!.validate()) {
              //       await boardController.writeBoard(
              //           boardController.board.value.board_id ?? -1,
              //           _title.text,
              //           _content.text);
              //       // 같은 page가 있으면 이동할 때 덮어씌우기 이게 최고!!
              //       Get.back(); // 상태관리 GetX 라이브러리 - Obs
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
