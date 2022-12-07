
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/store_detail_info/store_info_controller.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ReviewDetailFragment extends GetView<StoreInfoController> {
  const ReviewDetailFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewDetailModel = controller.reviewDetailModel.value!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '리뷰 작성',
          ),
        ),
        body: reviewDetailModel.question!.isEmpty
            ? _buildNotExistWidget()
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: GapSize.xxxSmall),
                shrinkWrap: true,
                itemCount: controller.getQuestionLength(reviewDetailModel.question!.length),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: GapSize.medium, vertical: GapSize.xxxSmall),
                    child: Container(
                      decoration: shadowBoxDecoration,
                      child: Column(
                        children: [
                          Container(
                            child: ListTile(
                              minVerticalPadding: GapSize.xSmall,
                              title: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: GapSize.xxSmall),
                                child: Text(controller.reviewDetailModel.value!.question![index].questionText!,
                                  style: mediumNanumTextStyle,
                                  textAlign: TextAlign.center),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: GapSize.xxSmall),
                                child: Obx(() => RatingStars(
                                  valueLabelVisibility: false,
                                  value: controller.questionRate[index].value,
                                  onValueChanged: (v) {
                                    controller.questionRate[index].value = v;
                                  },
                                  starSpacing: GapSize.xSmall,
                                  starCount: 5,
                                  starSize: 32,
                                  starOffColor: const Color(0xffe7e8ea),
                                  starColor: Colors.yellow,
                                )),
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

        //     Container(
        //       margin: const EdgeInsets.symmetric(
        //           vertical: GapSize.xxxSmall,
        //           horizontal: GapSize.medium),
        //       decoration: shadowBoxDecoration,
        //       child: TextField(
        //         controller: controller.modifyText,
        //         keyboardType: TextInputType.multiline,
        //         maxLines: 3,
        //         decoration: const InputDecoration(
        //             filled: false,
        //             hintText: "리뷰를 입력해주세요.",
        //             hintStyle: TextStyle(
        //                 fontSize: FontSize.small,
        //                 color: Colors.grey,
        //                 fontFamily: "NotoR"),
        //             enabledBorder:
        //             OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
        //             focusedBorder:
        //             OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
        //             contentPadding: EdgeInsets.symmetric(
        //                 vertical: GapSize.small, horizontal: GapSize.small)),
        //         style: const TextStyle(
        //             fontSize: FontSize.small, fontFamily: "NotoR"),
        //       ),
        //     ),
        //   ],
        // ),
      // ),
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
          Text("질문이 없습니다."),
        ],
      ),
    );
  }
}