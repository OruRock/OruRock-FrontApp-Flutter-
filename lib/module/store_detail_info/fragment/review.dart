import 'package:auto_size_text/auto_size_text.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oru_rock/common_widget/rating_view.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/model/store_detail_model.dart' as storeDetailModel;
import 'package:oru_rock/model/store_model.dart' as storeModel;
import 'package:oru_rock/module/store_detail_info/fragment/review_detail.dart';
import 'package:oru_rock/module/store_detail_info/store_info_controller.dart';

class ReviewFragment extends GetView<StoreInfoController> {
  final storeModel.StoreModel? store;

  const ReviewFragment({
    required this.store,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(children: [
        controller.reviews.isEmpty
            ? _buildNotExistWidget()
            : Padding(
                padding: const EdgeInsets.only(top: GapSize.medium),
                child: Column(
                  children: [
                    Obx(
                      () => Expanded(
                        child: ListView(
                          controller: controller.reviewScrollController,
                          shrinkWrap: true,
                          children: List.generate(
                            controller.reviews.value.length,
                            (index) {
                              return _buildReviewTile(index);
                            },
                          ),
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
              backgroundColor: Colors.black,
              onPressed: () {
                Get.to(() => ReviewDetailFragment(store: store));
                // Get.bottomSheet(_buildReviewTextField(),
                //     barrierColor: Colors.black26);
              },
              child: const Icon(Icons.edit_outlined),
            ),
          ),
        )
      ]),
    );
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            EvaIcons.fileTextOutline,
            size: 50,
          ),
          SizedBox(
            height: GapSize.small,
          ),
          Text("리뷰가 없습니다."),
        ],
      ),
    );
  }

  _buildReviewTile(int index) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.reviewDetailContainerVisible[index].value =
              !controller.reviewDetailContainerVisible[index].value;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: GapSize.xxSmall),
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(
                horizontal: GapSize.small, vertical: GapSize.small),
            decoration: shadowBoxDecoration,
            child: Stack(
              children: [
                Column(
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
                                size: const Size.fromRadius(20),
                                // Image radius
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Image.asset(controller.app.levelImage[
                                      controller.reviews[index].userLevel ??
                                          0]),
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
                              controller.reviews[index].userNickname ??
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: GapSize.xxxSmall),
                          child: GestureDetector(
                            onTap: () {
                              controller.settingContainerVisible[index].value =
                                  true;
                            },
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.grey,
                              size: WidthWithRatio.xSmall,
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
                          controller.reviews[index].createDate!)),
                      style: const TextStyle(
                          fontFamily: "NotoR",
                          fontSize: FontSize.xSmall,
                          color: Colors.grey),
                    ),
                    Container(
                      height: GapSize.small,
                      alignment: Alignment.center,
                      child: AnimatedCrossFade(
                        firstChild: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.grey,
                        ),
                        secondChild: Container(),
                        crossFadeState: !controller
                                .reviewDetailContainerVisible[index].value
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: Duration(milliseconds: 100),
                      ),
                    ),
                    _buildReviewDetail(index),
                  ],
                ),
                Obx(
                  () => Align(
                    alignment: Alignment.topRight,
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: controller.settingContainerVisible[index].value
                            ? Container(
                                width: 105,
                                padding: const EdgeInsets.all(GapSize.small),
                                decoration: shadowBoxDecoration,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.buildReportDialog(
                                            store!.storeId!,
                                            controller
                                                .reviews[index].commentId!);
                                        controller
                                            .settingContainerVisible[index]
                                            .value = false;
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.report_rounded,
                                            color: Colors.red,
                                            size: WidthWithRatio.xSmall,
                                          ),
                                          const Text(
                                            '신고',
                                            style:
                                                TextStyle(fontFamily: "NotoM"),
                                          )
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                        visible:
                                            controller.reviews[index].uid ==
                                                controller.auth.user?.uid,
                                        child: const Divider()),
                                    Visibility(
                                      visible: controller.reviews[index].uid ==
                                          controller.auth.user?.uid,
                                      child: GestureDetector(
                                        onTap: () async {
                                          controller.buildWarningDialog(
                                              store!.storeId!,
                                              controller
                                                  .reviews[index].commentId!);
                                          controller
                                              .settingContainerVisible[index]
                                              .value = false;
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              size: WidthWithRatio.xSmall,
                                              color: Colors.grey,
                                            ),
                                            const Text('삭제',
                                                style: TextStyle(
                                                    fontFamily: "NotoM"))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : null),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildReviewDetail(int reviewIndex) {
    storeDetailModel.Comment review = controller.reviews[reviewIndex];

    return AnimatedCrossFade(
        firstChild: Container(
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(RadiusSize.medium)),
            color: Colors.grey[200],
          ),
          height: 70.0 * controller.reviewDetailModel.value!.question!.length,
          child: ListView.separated(
            itemCount: controller.reviewDetailModel.value!.question!.length,
            itemBuilder: (BuildContext context, int index) {
              int answerIndex = review.reviewRate!.indexWhere((answer) => answer.questionId == controller.reviewDetailModel.value!.question![index].questionId);
              return SizedBox(
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        '${controller.reviewDetailModel.value!.question![index].questionText}'),
                    const SizedBox(
                      height: GapSize.xxSmall,
                    ),
                    answerIndex == -1 ?
                        RatingView(rate: 0.0) :
                    RatingView(rate: review.reviewRate![answerIndex].answerValue!)
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 1,
                color: Colors.grey,
              );
            },
          ),
        ),
        secondChild: Container(),
        crossFadeState: controller.reviewDetailContainerVisible[reviewIndex].value
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 300));
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
                        controller.modifyReview(store!.storeId!,
                            controller.reviews[index].commentId!);
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
              controller.reviews[index].comment!,
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
