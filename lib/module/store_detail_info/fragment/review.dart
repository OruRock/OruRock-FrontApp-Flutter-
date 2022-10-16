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
    return Expanded(
      child: controller.reviewModel.value!.total == 0
          ? Center(
              child: Row(
                children: [
                  const Icon(Icons.cancel_presentation),
                  const Text("리뷰가 없습니다!"),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: GapSize.medium),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                        shrinkWrap: true,
                        children: List.generate(
                            controller.reviewModel.value!.comment!.length,
                            (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.reviewModel.value!
                                        .comment![index].userNickname!,
                                    style: reviewNickNameTextStyle,
                                  ),
                                  Text(
                                    DateFormat('yy.MM.dd').format(
                                        DateTime.parse(controller
                                            .reviewModel
                                            .value!
                                            .comment![index]
                                            .createDate!)),
                                    style: reviewContentTextStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: GapSize.xxSmall,
                              ),
                              Text(
                                controller.reviewModel.value!.comment![index]
                                    .comment!,
                                style: reviewContentTextStyle,
                              ),
                              const Divider(
                                height: GapSize.small,
                                thickness: 1.0,
                                color: Colors.grey,
                              )
                            ],
                          );
                        })),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextField(
                          controller: controller.reviewText,
                          keyboardType: TextInputType.multiline,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              filled: false,
                              hintText: "리뷰를 입력해주세요.",
                              hintStyle: TextStyle(
                                  fontSize: FontSize.small,
                                  color: Colors.grey,
                                  fontFamily: "NanumR"),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.0)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: GapSize.small,
                                  horizontal: GapSize.small)),
                          style: const TextStyle(
                              fontSize: FontSize.small, fontFamily: "NanumR"),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                            onPressed: () {
                              controller.createReview(store!.storeId!);
                            },
                            child: const Text("저장")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
