import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/store_detail_info/store_info_controller.dart';
import 'package:oru_rock/model/store_detail_model.dart' as detailModel;
import 'package:oru_rock/model/store_model.dart' as storeModel;

class ReviewFragment extends GetView<StoreInfoController> {
  final storeModel.StoreModel? store;
  final detailModel.StoreReviewModel? review;

  const ReviewFragment({
    required this.store,
    required this.review,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: review!.total == 0
          ? Container()
          : ListView(
              shrinkWrap: true,
              children:
                  List.generate(review!.comment!.length, (index) {
                    return ListTile(
                      title: Text(review!.comment![index].userNickname!),
                      subtitle: Text(review!.comment![index].comment!),
                    );
                  })),
    );
  }
}
