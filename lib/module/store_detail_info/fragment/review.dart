import 'package:auto_size_text/auto_size_text.dart';
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
    return Obx(() => Expanded(
          child: Stack(children: [
            controller.detailModel.value!.comment!.isEmpty
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
                      ],
                    ),
                  ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: GapSize.small),
                child: FloatingActionButton(
                  onPressed: () {
                    Get.bottomSheet(_buildReviewTextField(),
                        barrierColor: Colors.black26);
                  },
                  child: const Icon(Icons.edit_outlined),
                ),
              ),
            )
          ]),
        ));
  }

  _buildReviewTextField() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: GapSize.small, vertical: GapSize.xSmall),
          child: TextField(
            controller: controller.reviewText,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    if (controller
                        .reviewTextFieldValidator(controller.reviewText)) {
                      await controller.createReview(store!.storeId!);
                      Get.back();
                    }
                  },
                  icon: const Icon(
                    Icons.send_outlined,
                    color: Colors.blue,
                  ),
                ),
                filled: false,
                hintText: "리뷰를 작성해주세요.",
                hintStyle: const TextStyle(
                    fontSize: FontSize.small,
                    color: Colors.grey,
                    fontFamily: "NotoR"),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: GapSize.small, horizontal: GapSize.small)),
            style:
                const TextStyle(fontSize: FontSize.small, fontFamily: "NotoR"),
          ),
        ),
      ),
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
      ],
    );
  }

  _buildReviewTile(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: GapSize.xxSmall),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(
            horizontal: GapSize.small, vertical: GapSize.small),
        decoration: shadowBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey)),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                        size: const Size.fromRadius(20), // Image radius
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Image.asset(controller.app.levelImage[5]),
                        )),
                  ),
                ),
                const SizedBox(
                  width: GapSize.xxSmall,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.detailModel.value!.comment![index]
                              .userNickname ??
                          '무명 클라이머',
                      style: reviewNickNameTextStyle,
                    ),
                    const SizedBox(
                      height: GapSize.xxxSmall,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 15,
                        ),
                      ],
                    )
                  ],
                ),
                Expanded(child: Container()),
                Visibility(
                  visible: controller.detailModel.value!.comment![index].uid ==
                      controller.auth.user?.uid,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: GapSize.xxxSmall),
                    child: GestureDetector(
                      onTap: () {
                        controller.modifyButtonPressed(index);
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: WidthWithRatio.xSmall,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.detailModel.value!.comment![index].uid ==
                      controller.auth.user?.uid,
                  child: GestureDetector(
                    onTap: () async {
                      controller.buildWarningDialog(
                          store!.storeId!,
                          controller
                              .detailModel.value!.comment![index].commentId!);
                    },
                    child: Icon(
                      Icons.delete,
                      size: WidthWithRatio.xSmall,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            controller.isModifying.value &&
                    controller.modifyingIndex.value == index
                ? _buildModifyTextField(index)
                : _buildCommentField(index),
            Text(
              DateFormat('yy.MM.dd').format(DateTime.parse(
                  controller.detailModel.value!.comment![index].createDate!)),
              style: const TextStyle(
                  fontFamily: "NotoR",
                  fontSize: FontSize.xSmall,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  _buildModifyTextField(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: GapSize.xSmall),
      child: Row(
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
                      fontFamily: "NotoR"),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: GapSize.small, horizontal: GapSize.small)),
              style: const TextStyle(
                  fontSize: FontSize.small, fontFamily: "NotoR"),
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
                    child: const AutoSizeText(
                      "수정",
                      maxLines: 1,
                      minFontSize: 8,
                      style:
                          TextStyle(color: Colors.black, fontFamily: "NotoM"),
                    )),
                OutlinedButton(
                    onPressed: () {
                      controller.cancelModify();
                    },
                    child: const AutoSizeText(
                      "취소",
                      maxLines: 1,
                      minFontSize: 8,
                      style:
                          TextStyle(color: Colors.black, fontFamily: "NotoM"),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildCommentField(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: GapSize.xSmall),
            child: Text(
              controller.detailModel.value!.comment![index].comment!,
              style: reviewContentTextStyle,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
}
