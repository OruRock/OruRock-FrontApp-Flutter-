import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/common_widget/alert_dialog.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/function/map_func.dart';
import 'package:oru_rock/model/store_model.dart';
import 'package:oru_rock/module/marker_detail/marker_detail.dart';
import 'package:oru_rock/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class AppController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  final api = Get.find<ApiFunction>();
  final auth = Get.find<AuthFunction>();
  final map = Get.find<MapFunction>();
  final appData = GetStorage();

  var isOnCloseApp = false;

  var stores = <StoreModel>[].obs; //store 관리
  var searchStores = <StoreModel>[].obs;
  ScrollController searchScrollController = ScrollController();
  var searchListPage = 1.obs;
  var isEnd = false.obs;
  var isGetMoreData = false.obs;
  var selectedIndex = 0; //선택된 storeIndex
  RxList<Marker> markers = <Marker>[].obs;

  var isPinned = GetStorage().read("PIN") != null ? true.obs : false.obs;
  int? pinnedStoreId = GetStorage().read("PIN");
  var pinnedStoreName = ''.obs;
  var detailPinState = false.obs;

  BannerAd? bannerAd;
  TextEditingController searchText = TextEditingController();

  var isLoading = false.obs;
  var selectedTabIndex = Tabs.home.obs;

  void onInit() async {
    await getStoreList();
    setMarker();
    searchScrollController.addListener(_searchScrollListener);
    pinnedStoreName.value =
        pinnedStoreId != null ? stores[pinnedStoreId!].storeName! : '';

    ever(selectedTabIndex, (value) {
      switch (value) {
        case Tabs.home:
          break;
        case Tabs.search:
          searchText.text = '';
          searchStores.value = stores.value; //검색 초기화
          isEnd.value = true;
          break;
        case Tabs.nmap:
          getLocationPermission();
          break;
        case Tabs.setting:
          break;
      }
    });
  }

  void onCloseApp() {
    isOnCloseApp = true;
    Future.delayed(const Duration(milliseconds: 3000), () {
      isOnCloseApp = false;
    });
  }
  _searchScrollListener() {
    if (searchScrollController.offset >=
        searchScrollController.position.maxScrollExtent * 0.8 &&
        !searchScrollController.position.outOfRange &&
        !isEnd.value) {
      ++searchListPage;
      addSearch();
    }
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

  void getLocationPermission() async {
    final locationPermissionStatus = await Permission.location.request();
  }

  ///뽑아온 Store 리스트[stores]에 따라 마커를 추가해준다.
  ///각 마커마다 onTap했을시, 해당하는 마커에 대한 데이터가 들어간다.
  void setMarker() async {
    int index = 0;
    OverlayImage overlayImage = await OverlayImage.fromAssetImage(
        assetName: 'asset/image/icon/pin_icon.png'); //마커 이미지
    for (var elem in stores) {
      markers.add(Marker(
          icon: overlayImage,
          width: 30,
          height: 30,
          markerId: index.toString(),
          position: LatLng(elem.storeLat!, elem.storeLng!),
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

  ///핀버튼 누를 시에 추가, 삭제, 교체가 일어나는 함수
  void setPin() {
    int? pin = appData.read("PIN");
    //핀이 없는 경우
    if (pin == null) {
      appData.write("PIN", selectedIndex);
      isPinned.value = true;
      detailPinState.value = true;
      pinnedStoreId = selectedIndex;
      pinnedStoreName.value = stores[pinnedStoreId!].storeName!;
      Fluttertoast.showToast(msg: "선택하신 암장이 고정되었습니다.");
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
    pinnedStoreName.value = stores[pinnedStoreId!].storeName!;
  }

  void removePin() {
    appData.remove("PIN");
    isPinned.value = false;
    detailPinState.value = false;
    pinnedStoreId = null;
    pinnedStoreName.value = '';
    Fluttertoast.showToast(msg: "핀이 해제되었습니다.");
  }

  void setDetailPinState() {
    if (selectedIndex == appData.read("PIN")) {
      detailPinState.value = true;
    } else {
      detailPinState.value = false;
    }
  }

  void goMapToSelectedStore(int index) async {
    selectedTabIndex.value = Tabs.nmap;
    map.nmapController = Completer();
    map.setCamera(markers[index].position!, 18.0);
    showDetailInformation(markers[index], {"height": null, "width": null});
  }

  Future<void> search() async {
    isLoading.value = true;
    isEnd.value = false;
    try {
      final data = {"search_txt": searchText.text, "page": searchListPage.value};
      final res = await api.dio.get('/store/list', queryParameters: data);

      final List<dynamic>? storeData = res.data['payload']['result'];
      if (storeData != null) {
        searchStores.value =
            storeData.map((map) => StoreModel.fromJson(map)).toList();
      }
      if(res.data['payload']['isEnd']) {
        isEnd.value = true;
        searchListPage.value = 1;
      }
      print(searchStores.value.length);
    } catch (e) {
      Logger().e(e.toString());
    }
    isLoading.value = false;
  }

  Future<void> addSearch() async {
    isGetMoreData.value = true;
    try {
      final data = {"search_txt": searchText.text, "page": searchListPage.value};
      final res = await api.dio.get('/store/list', queryParameters: data);

      final List<dynamic>? storeData = res.data['payload']['result'];
      if (storeData != null) {
        searchStores +=
            storeData.map((map) => StoreModel.fromJson(map)).toList();
      }
      if(res.data['payload']['isEnd']) {
        isEnd.value = true;
        searchListPage.value = 1;
      }
      print(searchStores.value.length);
    } catch (e) {
      Logger().e(e.toString());
      isGetMoreData.value = false;
    }
    isGetMoreData.value = false;
  }
}



enum Tabs {
  home,
  search,
  nmap,
  setting;

  String get routeString {
    switch (this) {
      case Tabs.home:
        return Routes.home;
      case Tabs.search:
        return Routes.search;
      case Tabs.nmap:
        return Routes.nmap;
      case Tabs.setting:
        return Routes.setting;
    }
  }

  static Tabs getTabByIndex(int index) {
    switch (index) {
      case 0:
        return Tabs.home;
      case 1:
        return Tabs.search;
      case 2:
        return Tabs.nmap;
      case 3:
        return Tabs.setting;
      default:
        return Tabs.home;
    }
  }
}
