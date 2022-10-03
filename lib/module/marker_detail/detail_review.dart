import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/model/store_model.dart' as model;
import 'package:oru_rock/module/marker_detail/marker_detail_controller.dart';

class DetailReview extends GetView<MarkerDetailController> {
  final model.StoreModel? store;

  const DetailReview({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(title: Text('리뷰에용')),
        ListTile(title: Text('리뷰에용')),
        ListTile(title: Text('리뷰에용')),
        ListTile(title: Text('리뷰에용')),
        ListTile(title: Text('리뷰에용')),
        ListTile(title: Text('리뷰에용')),
        ListTile(title: Text('리뷰에용')),
        ListTile(title: Text('리뷰에용')),
        ListTile(title: Text('리뷰에용')),
        ListTile(title: Text('리뷰에용')),
        ListTile(title: Text('리뷰에용')),
        ListTile(title: Text('리뷰에용')),
      ],
    );
  }
}
