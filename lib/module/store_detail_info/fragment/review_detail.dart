import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/model/store_model.dart' as storeModel;
import 'package:oru_rock/module/store_detail_info/fragment/review_detail_write.dart';
import 'package:oru_rock/module/store_detail_info/store_info_controller.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ReviewDetailFragment extends GetView<StoreInfoController> {
  final storeModel.StoreModel? store;

  const ReviewDetailFragment({
    required this.store,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviewDetailModel = controller.reviewDetailModel.value!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(store?.storeName ?? "")
          ),
        body: Column(
          children: [
            Container(
              width: Get.width,
              color: const Color(0xFF5A6170),
              padding: const EdgeInsets.symmetric(vertical: GapSize.xxxSmall),
              child: const Text("리뷰 작성 1/2",
                style: regularEllipsisNanumWhiteTextStyle,
                textAlign: TextAlign.center,),
            ),
            reviewDetailModel.question!.isEmpty
              ? _buildNotExistWidget()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: GapSize.xxxSmall),
                  shrinkWrap: true,
                  itemCount: controller.getQuestionLength(reviewDetailModel.question!.length),
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(() =>
                        _buildRatingStarsField(index, reviewDetailModel.question!.length)
                    );
                  },
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GapSize.medium),
              child: Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      padding: EdgeInsets.symmetric(vertical: GapSize.xSmall),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        Get.to(() => ReviewDetailWriteFragment(store: store));
                      },
                      color: const Color(0xFF9DA6B8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("SKIP", style: TextStyle(color: Colors.white, fontFamily: "NotoM"), textAlign: TextAlign.center,),
                          SizedBox(
                            width: GapSize.small,
                          ),
                          Icon(Icons.keyboard_double_arrow_right_rounded, color: Colors.white,),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: GapSize.small,
                  ),
                  Expanded(
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: GapSize.xSmall),
                       shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        Get.to(() => ReviewDetailWriteFragment(store: store));
                      },
                      color: const Color(0xFF5A6170),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("NEXT", style: TextStyle(color: Colors.white, fontFamily: "NotoM")),
                          SizedBox(
                            width: GapSize.small,
                          ),
                          Icon(Icons.check, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
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
          Text("질문이 없습니다."),
        ],
      ),
    );
  }

  _buildRatingStarsField(int index, int length) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: GapSize.medium, vertical: GapSize.xxxSmall),
      child: Container(
        decoration: shadowBoxDecoration,
        child: Column(
          children: [
            ListTile(
              minVerticalPadding: GapSize.medium,
              title: Padding(
                padding: const EdgeInsets.only(
                    bottom: GapSize.medium),
                child: Text(controller.reviewDetailModel.value!.question![index].questionText!,
                    style: mediumNanumTextStyle,
                    textAlign: TextAlign.center),
              ),
              subtitle: Container (
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: GapSize.small),
                  child: RatingStars(
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}