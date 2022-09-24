import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:oru_rock/model/store_model.dart';
import 'package:oru_rock/module/marker_detail/marker_detail_controller.dart';

class MarkerDetail extends GetView<MarkerDetailController> {
  final StoreModel? store;

  const MarkerDetail({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text('${store!.stroreName} and ${store!.storeAddr}'),
        ),
      ),
    );
  }
}
