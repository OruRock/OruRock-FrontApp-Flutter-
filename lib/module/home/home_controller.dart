import 'dart:async';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/common_widget/alert_dialog.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/map_func.dart';
import 'package:oru_rock/model/store_detail_model.dart';
import 'package:oru_rock/model/store_model.dart';
import 'package:oru_rock/module/marker_detail/marker_detail.dart';

class HomeController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  final api = Get.find<ApiFunction>();
  final map = Get.find<MapFunction>();
  final appData = GetStorage();

  var isPinned = GetStorage().read("PIN") != null ? true.obs : false.obs;
  int? pinnedStoreId = GetStorage().read("PIN");
  var pinnedStoreName = ''.obs;
  var detailPinState = false.obs;

  var stores = <StoreModel>[].obs; //store 관리
  var selectedIndex = 0; //선택된 storeIndex

  RxList<Marker> markers = <Marker>[].obs;

  @override
  void onInit() async {
    await getStoreList();
    setMarker();
    pinnedStoreName.value =
        pinnedStoreId != null ? stores[pinnedStoreId!].stroreName! : '';
    super.onInit();
  }

  ///암장 리스트 정보 API 연결 함수
  Future<void> getStoreList() async {
    try {
      final res = await api.dio.get('/store/list');

      final List<dynamic>? data = res.data['payload']['result'];
      if (data != null) {
        stores.value = data.map((map) => StoreModel.fromJson(map)).toList();
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  ///뽑아온 Store 리스트[stores]에 따라 마커를 추가해준다.
  ///각 마커마다 onTap했을시, 해당하는 마커에 대한 데이터가 들어간다.
  void setMarker() async {
    int index = 0;
    for (var elem in stores) {
      markers.add(Marker(
          markerId: index.toString(),
          position: LatLng(
              elem.storeLat!, elem.storeLng!),
          onMarkerTab: showDetailInformation));
      index++;
    }
  }

  ///각 마커 onTap시 함수
  void showDetailInformation(Marker? marker, Map<String, int?> iconSize) async {
    final markerId = int.parse(marker!.markerId);

    selectedIndex = markerId; //selectedIndex 업데이트

    setDetailPinState();

    Get.bottomSheet(MarkerDetail(store: stores[markerId]));

    //Get.to(() => MarkerDetail(store: stores[int.parse(marker!.markerId) - 1]));
  }

  ///해당하는 암장의 리뷰데이터 가져오는 함수
  Future<StoreReviewModel?> getReviewList(int index) async {
    try {
      final reqData = {
        "store_id": index.toString(),
        "commentOnly": false,
      };

      final res = await api.dio.get('/store/detail', queryParameters: reqData);

      final Map<String, dynamic>? data = res.data['payload'];
      if (data != null) {
        return StoreReviewModel.fromJson(data);
      }
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
    return null;
  }

  ///핀버튼 누를 시에 추가, 삭제, 교체가 일어나는 함수
  void setPin() {
    int? pin = appData.read("PIN");
    //핀이 없는 경우
    if (pin == null) {
      appData.write("PIN", selectedIndex);
      isPinned.value = true;
      detailPinState.value = true;
      pinnedStoreId = selectedIndex;
      pinnedStoreName.value = stores[pinnedStoreId!].stroreName!;
      Get.snackbar("알림", "선택하신 암장이 고정되었습니다");
      return;
    }

    //같은 암장 한번 더 눌렀을 경우 핀 해제
    if (pin == selectedIndex) {
      removePin();
      Get.snackbar("알림", "핀 해제");
      return;
    }

    //핀한 암장 교체 확인 -> [updatePin], 취소 -> 변화 X
    Get.dialog(CommonDialog(
        title: "알림",
        content: "이미 고정되어있는 암장이 있습니다. 현재 선택한 암장으로 변경하시겠습니까?",
        positiveFunc: updatePin));
  }

  void updatePin() {
    appData.write("PIN", selectedIndex);
    pinnedStoreId = selectedIndex;
    detailPinState.value = true;
    pinnedStoreName.value = stores[pinnedStoreId!].stroreName!;
  }

  void removePin() {
    appData.remove("PIN");
    isPinned.value = false;
    detailPinState.value = false;
    pinnedStoreId = null;
    pinnedStoreName.value = '';
  }

  void setDetailPinState() {
    if (selectedIndex == appData.read("PIN")) {
      detailPinState.value = true;
    } else {
      detailPinState.value = false;
    }
  }
}
