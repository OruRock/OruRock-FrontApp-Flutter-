import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/common_widget/alert_dialog.dart';
import 'package:oru_rock/constant/style/size.dart';
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
  var imageSliderHeight = HeightWithRatio.xxxLarge.obs;
  final imageHeight = [HeightWithRatio.xxxLarge, 0.0];

  late ScrollController scrollController;

  TextEditingController reviewText = TextEditingController();
  TextEditingController modifyText = TextEditingController();
  var isModifying = false.obs;
  var modifyingIndex = (-1).obs;

  @override
  void onInit() async {
    scrollController = ScrollController();
    detailModel.value = await getReview();
    super.onInit();
  }

  ///리뷰 추가 API
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

  void modifyButtonPressed(int index) {
    modifyText.text = detailModel.value!.comment![index].comment!;
    isModifying.value = true;
    modifyingIndex.value = index;
  }

  void cancelModify() {
    isModifying.value = false;
    modifyingIndex.value = -1;
  }

  ///리뷰 수정 API
  Future<void> modifyReview(int storeId, int commentId) async {
    try {
      isLoading.value = false;

      final modifyData = {
        "store_id": storeId,
        "uid": "TdAakxoDZ9S0awZqFttN2ktxQYm1",
        "comment": modifyText.text,
        "recommend_level": 0,
        "comment_id": commentId.toString(),
      };

      final res = await api.dio.post('/store/comment', data: modifyData);

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
        isModifying.value = false;
        modifyingIndex.value = -1;
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  ///리뷰 삭제시 Dialog
  void buildWarningDialog(int storeId, int commentId) {
    Get.dialog(CommonDialog(
        title: "경고",
        content: "정말 삭제하시겠습니까?",
        positiveFunc: () async {
          await deleteReview(storeId, commentId);
        }));
  }

  ///리뷰 삭제 API
  Future<void> deleteReview(int storeId, int commentId) async {
    try {
      isLoading.value = false;

      final deleteData = {
        "comment_id": commentId,
        "uid": "TdAakxoDZ9S0awZqFttN2ktxQYm1",
      };

      final res =
          await api.dio.delete('/store/comment', queryParameters: deleteData);

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

  ///리뷰 새로 고침
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

  bool reviewTextFieldValidator(TextEditingController controller) {
    if (controller.text.length < 3) {
      Get.snackbar("알림", "3글자 이상 작성해주세요:)");
      return false;
    }
    return true;
  }
}
