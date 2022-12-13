import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/store_detail_info/store_info_controller.dart';
import '../../../constant/style/style.dart';
import 'package:oru_rock/model/store_model.dart' as storeModel;


class ReviewDetailWriteFragment extends GetView<StoreInfoController> {
  final storeModel.StoreModel? store;

  const ReviewDetailWriteFragment({
    required this.store,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '리뷰 작성',
          ),
        ),
        body: Column(
          children: [
            Container(
            width: Get.width,
            color: const Color(0xFF5A6170),
            padding: const EdgeInsets.symmetric(vertical: GapSize.xxxSmall),
            child: const Text("리뷰 작성 2/2",
              style: regularEllipsisNanumWhiteTextStyle,
              textAlign: TextAlign.center,),
            ),
            ListTile(
              minVerticalPadding: GapSize.xxLarge,
              title: const Padding(
                padding: EdgeInsets.only(
                    bottom: GapSize.medium),
                child: Text("즐거웠나요?",
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
                    value: 0.0,
                    onValueChanged: (v) {
                      v;
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
            const Divider(
              height: 1.0,
              thickness: 1.0,
              indent: 10.0,
              endIndent: 10.0,
            ),
            Container(
              padding: const  EdgeInsets.symmetric(vertical: GapSize.large),
              child: const Text("암장에서의 경험을 공유해 주세요.")
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: GapSize.xxxSmall,
                  horizontal: GapSize.medium),
              decoration: shadowBoxDecoration,
              child: TextField(
                controller: controller.modifyText,
                keyboardType: TextInputType.multiline,
                maxLines: 15,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GapSize.medium, vertical: GapSize.xxSmall),
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: GapSize.small),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onPressed: () {
                  // Get.to(() => ReviewFragment(store: store));
                },
                color: const Color(0xFF5A6170),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("완료", style: TextStyle(color: Colors.white, fontFamily: "NotoM")),
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
      ),
    );
  }
}