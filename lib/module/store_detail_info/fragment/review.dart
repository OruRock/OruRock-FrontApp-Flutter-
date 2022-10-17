import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/store_detail_info/store_info_controller.dart';
import 'package:oru_rock/model/store_model.dart' as storeModel;

class ReviewFragment extends GetView<StoreInfoController> {
  final storeModel.StoreModel? store;

  const ReviewFragment({
    required this.store,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: controller.detailModel.value!.comment!.isEmpty
            ? _buildNotExistWidget()
            : Padding(
                padding: const EdgeInsets.only(top: GapSize.medium),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: List.generate(
                          controller.detailModel.value!.comment!.length,
                          (index) {
                            return _buildReviewTile(index);
                          },
                        ),
                      ),
                    ),
                    Visibility(
                        visible: !controller.isModifying.value,
                        child: _buildReviewTextField())
                  ],
                ),
              ),
      ),
    );
  }

  _buildReviewTextField() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 5,
          child: TextField(
            controller: controller.reviewText,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            decoration: const InputDecoration(
                filled: false,
                hintText: "리뷰를 입력해주세요.",
                hintStyle: TextStyle(
                    fontSize: FontSize.small,
                    color: Colors.grey,
                    fontFamily: "NanumR"),
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
                contentPadding: EdgeInsets.symmetric(
                    vertical: GapSize.small, horizontal: GapSize.small)),
            style:
                const TextStyle(fontSize: FontSize.small, fontFamily: "NanumR"),
          ),
        ),
        const SizedBox(
          width: GapSize.xSmall,
        ),
        Expanded(
          flex: 1,
          child: OutlinedButton(
              onPressed: () {
                if (controller
                    .reviewTextFieldValidator(controller.reviewText)) {
                  controller.createReview(store!.storeId!);
                }
              },
              child: const Text("저장")),
        ),
      ],
    );
  }

  _buildNotExistWidget() {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.cancel_presentation),
              SizedBox(
                width: GapSize.small,
              ),
              Text("리뷰가 없습니다!"),
            ],
          ),
        ),
        _buildReviewTextField()
      ],
    );
  }

  _buildReviewTile(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              controller.detailModel.value!.comment![index].userNickname!,
              style: reviewNickNameTextStyle,
            ),
            Expanded(child: Container()),
            Text(
              DateFormat('yy.MM.dd').format(DateTime.parse(
                  controller.detailModel.value!.comment![index].createDate!)),
              style: reviewContentTextStyle,
            ),
          ],
        ),
        const SizedBox(
          height: GapSize.xxSmall,
        ),
        controller.isModifying.value && controller.modifyingIndex.value == index
            ? _buildModifyTextField(index)
            : _buildCommentField(index),
        const Divider(
          height: GapSize.small,
          thickness: 1.0,
          color: Colors.grey,
        )
      ],
    );
  }

  _buildModifyTextField(int index) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 5,
          child: TextField(
            controller: controller.modifyText,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            decoration: const InputDecoration(
                filled: false,
                hintText: "리뷰를 입력해주세요.",
                hintStyle: TextStyle(
                    fontSize: FontSize.small,
                    color: Colors.grey,
                    fontFamily: "NanumR"),
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
                contentPadding: EdgeInsets.symmetric(
                    vertical: GapSize.small, horizontal: GapSize.small)),
            style:
                const TextStyle(fontSize: FontSize.small, fontFamily: "NanumR"),
          ),
        ),
        const SizedBox(
          width: GapSize.xSmall,
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              OutlinedButton(
                  onPressed: () {
                    if (controller
                        .reviewTextFieldValidator(controller.modifyText)) {
                      controller.modifyReview(
                          store!.storeId!,
                          controller
                              .detailModel.value!.comment![index].commentId!);
                    }
                  },
                  child: const Text("수정")),
              OutlinedButton(
                  onPressed: () {
                    controller.cancelModify();
                  },
                  child: const Text("취소")),
            ],
          ),
        ),
      ],
    );
  }

  _buildCommentField(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: WidthWithRatio.xxxxLarge,
          child: Text(
            controller.detailModel.value!.comment![index].comment!,
            style: reviewContentTextStyle,
            overflow: TextOverflow.clip,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Visibility(
          visible: controller.detailModel.value!.comment![index].uid ==
              "TdAakxoDZ9S0awZqFttN2ktxQYm1",
          //TODO 저장되어 있는 UID로
          child: GestureDetector(
            onTap: () {
              controller.modifyButtonPressed(index);
            },
            child: Icon(
              Icons.edit_outlined,
              color: Colors.blue,
              size: WidthWithRatio.xSmall,
            ),
          ),
        ),
        SizedBox(
          width: WidthWithRatio.xxxSmall,
        ),
        Visibility(
          visible: controller.detailModel.value!.comment![index].uid ==
              "TdAakxoDZ9S0awZqFttN2ktxQYm1",
          //TODO 저장되어 있는 UID로
          child: GestureDetector(
            onTap: () async {
              controller.buildWarningDialog(store!.storeId!,
                  controller.detailModel.value!.comment![index].commentId!);
            },
            child: Icon(
              Icons.delete_outline,
              size: WidthWithRatio.xSmall,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
