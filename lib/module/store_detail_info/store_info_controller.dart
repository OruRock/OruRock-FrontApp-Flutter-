import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/map_func.dart';
import 'package:oru_rock/model/store_detail_model.dart';
import 'package:oru_rock/module/home/home_controller.dart';

class StoreInfoController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final api = Get.find<ApiFunction>();
  final map = Get.find<MapFunction>();
  final home = Get.find<HomeController>();

  Rx<StoreReviewModel?> reviewModel = StoreReviewModel().obs;
  var isLoading = false.obs;

  var toggleList = ['암장 정보', '리뷰'];
  var selectedInfo = 0.obs;

  late ScrollController scrollController;

  TextEditingController reviewText = TextEditingController();

  @override
  void onInit() async {
    scrollController = ScrollController();
    reviewModel.value = await getReview();
  }

  Future<void> createReview(int storeId) async {
    try {
      isLoading.value = false;

      final reviewData = {
        "store_id": storeId,
        "uid": "TdAakxoDZ9S0awZqFttN2ktxQYm1",
        "comment": reviewText.text,
        "recommend_level": 0,
      };

      final res = await api.dio.post('/store/comment', data: reviewData);

      final reqData = {
        "store_id": storeId.toString(),
        "commentOnly": true,
      };

      final comment =
          await api.dio.get('/store/detail', queryParameters: reqData);

      final Map<String, dynamic>? data = comment.data['payload'];
      if (data != null) {
        isLoading.value = true;
        reviewModel.value!.comment = StoreReviewModel.fromJson(data).comment;
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<StoreReviewModel?> getReview() async {
    try {
      isLoading.value = false;
      final reqData = {
        "store_id": home.stores[home.selectedIndex].storeId.toString(),
        "commentOnly": false
      };
      final res = await api.dio.get('/store/detail', queryParameters: reqData);

      final Map<String, dynamic>? data = res.data['payload'];
      if (data != null) {
        isLoading.value = true;
        return StoreReviewModel.fromJson(data);
      }
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
    return null;
  }

  bool reviewTextFieldValidator() {
    if(reviewText.text.length < 3) {
      return false;
    }
    return true;
  }
}
