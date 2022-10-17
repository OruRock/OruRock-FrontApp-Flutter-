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
  var isLoading = false.obs; // 로딩용

  var toggleList = ['암장 정보', '리뷰'];
  var selectedInfo = 0.obs; //toogle 선택 index
  var imageSliderHeight = HeightWithRatio.xxxLarge.obs; // imageSlider 높이 애니메이션용
  final imageHeight = [HeightWithRatio.xxxLarge, 0.0]; // imageSlider 높이 애니메이션용

  TextEditingController reviewText =
      TextEditingController(); //리뷰 작성 텍스트 필드 컨트롤러
  TextEditingController modifyText =
      TextEditingController(); //리뷰 수정 텍스트 필드 컨트롤러
  var isModifying = false.obs; // 수정 중
  var modifyingIndex = (-1).obs; // 수정할 리뷰 인덱스

  @override
  void onInit() async {
    detailModel.value = await getReview();
    super.onInit();
  }

  ///리뷰 새로 고침
  Future<void> fetchReview(int storeId) async {
    try {
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

  ///리뷰 추가 API
  Future<void> createReview(int storeId) async {
    try {
      isLoading.value = false;

      final reviewData = {
        "store_id": storeId,
        "uid": "TdAakxoDZ9S0awZqFttN2ktxQYm1", //TODO 가져오는 UID로 수정
        "comment": reviewText.text,
        "recommend_level": 0,
      };

      final res = await api.dio.post('/store/comment', data: reviewData);

      await fetchReview(storeId);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  ///수정 버튼 누를 시
  void modifyButtonPressed(int index) {
    modifyText.text = detailModel.value!.comment![index].comment!;
    isModifying.value = true;
    modifyingIndex.value = index;
  }

  ///수정 취소 시
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

      await fetchReview(storeId);

      isModifying.value = false;
      modifyingIndex.value = -1;
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

      await fetchReview(storeId);

    } catch (e) {
      logger.e(e.toString());
    }
  }

  ///첫 리뷰 가져오는 함수
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

  ///리뷰 텍스트 필드 (수정, 추가) validator
  bool reviewTextFieldValidator(TextEditingController controller) {
    if (controller.text.length < 3) {
      Get.snackbar("알림", "3글자 이상 작성해주세요:)");
      return false;
    }
    return true;
  }
}
