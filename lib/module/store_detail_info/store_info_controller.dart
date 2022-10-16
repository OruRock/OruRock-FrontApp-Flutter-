import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/model/store_detail_model.dart';
import 'package:oru_rock/module/home/home_controller.dart';

class StoreInfoController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final api = Get.find<ApiFunction>();
  final home = Get.find<HomeController>();

  Rx<StoreDetailModel?> detailModel = StoreDetailModel().obs;
  var isLoading = false.obs;

  var toggleList = ['암장 정보', '리뷰'];
  var selectedInfo = 0.obs;

  late ScrollController scrollController;

  TextEditingController reviewText = TextEditingController();

  @override
  void onInit() async {
    scrollController = ScrollController();
    detailModel.value = await getReview();
    super.onInit();
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
        reviewText.text = '';
        StoreDetailModel newModel = StoreDetailModel.fromJson(data);
        detailModel.value!.total = newModel.total;
        detailModel.value!.comment = newModel.comment;
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<StoreDetailModel?> getReview() async {
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
        return StoreDetailModel.fromJson(data);
      }
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
    return null;
  }

  bool reviewTextFieldValidator() {
    if (reviewText.text.length < 3) {
      Get.snackbar("알림", "3글자 이상 작성해주세요:)");
      return false;
    }
    return true;
  }
}
