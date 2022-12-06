import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/common_widget/alert_dialog.dart';
import 'package:oru_rock/common_widget/report_dialog.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/model/store_detail_model.dart';
import 'package:oru_rock/module/app/app_controller.dart';

class StoreInfoController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final api = Get.find<ApiFunction>();
  final app = Get.find<AppController>();
  final auth = Get.find<AuthFunction>();

  Rx<StoreDetailModel?> detailModel = StoreDetailModel().obs;
  var isLoading = false.obs; // 로딩용

  var toggleList = ['암장 정보', '리뷰'];
  var selectedInfo = 0.obs; //toogle 선택 index
  var imageSliderHeight = (Get.height * 0.25).obs; // imageSlider 높이 애니메이션용
  final imageHeight = [(Get.height * 0.25) , 0.0]; // imageSlider 높이 애니메이션용

  TextEditingController reviewText =
      TextEditingController(); //리뷰 작성 텍스트 필드 컨트롤러
  TextEditingController modifyText =
      TextEditingController(); //리뷰 수정 텍스트 필드 컨트롤러
  var isModifying = false.obs; // 수정 중
  var modifyingIndex = (-1).obs; // 수정할 리뷰 인덱스

  List<RxBool> settingContainerVisible = [true.obs];

  @override
  void onInit() async {
    detailModel.value = await getReview();
    settingContainerVisible = List.generate(detailModel.value!.comment!.length, (index) => false.obs);
    super.onInit();
  }

  GestureDetector setStoreAddrHandler(String? text) {
    return GestureDetector(
      child: SelectableText(
        '$text',
        style: const TextStyle(
          fontFamily: "NotoR",
          fontSize: FontSize.small,
          overflow: TextOverflow.clip,
        ),
      ),
      onDoubleTap: () {
        Clipboard.setData(
          ClipboardData(text: text));
        Fluttertoast.showToast(msg: "복사 완료");
      },
    );
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
        "uid": auth.user.value!.uid, //TODO 가져오는 UID로 수정
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
        "uid": auth.user.value!.uid,
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

  ///리뷰 삭제시 Dialog
  void buildReportDialog(int storeId, int commentId) {
    Get.dialog(ReportDialog(
        title: "신고하기",
        reportFunc: (reportText) async {
          await reportReview(reportText, commentId);
        }));
  }

  Future<void> reportReview(String reportText, int commentId) async {
    try {
      final data = {
        "report_type": 1,
        "report_type_id": commentId,
        "report_title": "신고",
        "report_content": reportText,
        "uid": auth.user.value!.uid
      };

      await api.dio.post('/report', queryParameters: data);

      Fluttertoast.showToast(msg: "신고가 완료되었습니다.");

    } catch(e) {
      Logger().e(e.toString());
      Fluttertoast.showToast(msg: "신고에 실패하였습니다.");
    }
  }

  ///리뷰 삭제 API
  Future<void> deleteReview(int storeId, int commentId) async {
    try {
      isLoading.value = false;

      final deleteData = {
        "comment_id": commentId,
        "uid": auth.user.value!.uid,
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
        "store_id": app.stores[app.selectedIndex].storeId.toString(),
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
