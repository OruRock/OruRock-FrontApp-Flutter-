import 'dart:async';

import 'package:dio/src/response.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/common_widget/alert_dialog.dart';
import 'package:oru_rock/constant/storagekey.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/function/map_func.dart';
import 'package:oru_rock/helper/location_permission.dart';
import 'package:oru_rock/model/popup_model.dart';
import 'package:oru_rock/model/store_model.dart';
import 'package:oru_rock/module/marker_detail/marker_detail.dart';
import 'package:oru_rock/routes.dart';

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

  var detailButtonState = [false.obs, false.obs, false.obs];
  var isPinned =
      GetStorage().read(StorageKeys.pin) != null ? true.obs : false.obs;
  int? pinnedStoreId = GetStorage().read(StorageKeys.pin);
  var pinnedStoreName = ''.obs;

  //var detailPinState = false.obs;

  //var detailClientStoreBookMark = false.obs;
  var clientStoreBookMark = <StoreModel>[].obs;
  var clientLikedStore = <StoreModel>[].obs;

  //var setLikedStore = false.obs;
  var likeStoreCount = 0.obs;

  BannerAd? bannerAd;
  TextEditingController searchText = TextEditingController();

  var isLoading = false.obs;
  var selectedTabIndex = Tabs.home.obs;

  List<String> levelImage = [
    'asset/image/icon/profile/level_red.png',
    'asset/image/icon/profile/level_orange.png',
    'asset/image/icon/profile/level_yellow.png',
    'asset/image/icon/profile/level_green.png',
    'asset/image/icon/profile/level_blue.png',
    'asset/image/icon/profile/level_navy.png',
    'asset/image/icon/profile/level_purple.png',
    'asset/image/icon/profile/level_white.png',
    'asset/image/icon/profile/level_grey.png',
    'asset/image/icon/profile/level_black.png',
    'asset/image/icon/profile/level_master.png',
  ];

  @override
  void onInit() async {
    await hasLocationPermission();
    await getStoreList();
    await getClientStoreBookMark();
    await setMarker();
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
          break;
        case Tabs.setting:
          break;
      }
    });
    await getPopups();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  void onCloseApp() {
    isOnCloseApp = true;
    Future.delayed(const Duration(milliseconds: 3000), () {
      isOnCloseApp = false;
    });
  }

  _searchScrollListener() {
    if (searchScrollController.offset >=
            searchScrollController.position.maxScrollExtent &&
        !searchScrollController.position.outOfRange &&
        !isEnd.value) {
      ++searchListPage;
      addSearch();
    }
  }

  ///암장 리스트 정보 API 연결 함수
  Future<void> getStoreList() async {
    try {
      final location = await Geolocator.getCurrentPosition();
      Map<String, Object?> bookMarkData;
      if (await hasLocationPermission()) {
        bookMarkData = {
          "uid": auth.user.value!.uid,
          "user_lat": location.latitude,
          "user_lng": location.longitude,
        };
      } else {
        bookMarkData = {"uid": auth.user.value!.uid};
      }
      final res =
          await api.dio.get('/store/list', queryParameters: bookMarkData);

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
  Future<void> setMarker() async {
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
    map.setCamera(marker!.position!);

    final markerId = int.parse(marker!.markerId);

    selectedIndex = markerId; //selectedIndex 업데이트

    setDetailButtonState(stores[markerId]);

    likeStoreCount.value = stores[markerId].recommendCnt!;

    Get.bottomSheet(MarkerDetail(store: stores[markerId]));
    //Get.to(() => MarkerDetail(store: stores[int.parse(marker!.markerId) - 1]));
  }

  ///핀버튼 누를 시에 추가, 삭제, 교체가 일어나는 함수
  void setPin() {
    int? pin = appData.read(StorageKeys.pin);
    //핀이 없는 경우
    if (pin == null) {
      appData.write(StorageKeys.pin, stores[selectedIndex].storeId);
      isPinned.value = true;
      detailButtonState[0].value = true;
      pinnedStoreId = stores[selectedIndex].storeId;
      pinnedStoreName.value = stores[
              stores.indexWhere((element) => element.storeId == pinnedStoreId!)]
          .storeName!;
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
    appData.write(StorageKeys.pin, selectedIndex);
    pinnedStoreId = stores[selectedIndex].storeId;
    detailButtonState[0].value = true;
    pinnedStoreName.value = stores[
    stores.indexWhere((element) => element.storeId == pinnedStoreId!)]
        .storeName!;
  }

  void removePin() {
    appData.remove(StorageKeys.pin);
    isPinned.value = false;
    detailButtonState[0].value = false;
    pinnedStoreId = null;
    pinnedStoreName.value = '';
    Fluttertoast.showToast(msg: "핀이 해제되었습니다.");
  }

  void setDetailButtonState(StoreModel? store) {
    if (selectedIndex == appData.read(StorageKeys.pin)) {
      detailButtonState[0].value = true;
    } else {
      detailButtonState[0].value = false;
    }

    if (clientStoreBookMark.contains(store)) {
      detailButtonState[1].value = true;
    } else {
      detailButtonState[1].value = false;
    }

    if (clientLikedStore.contains(store)) {
      detailButtonState[2].value = true;
    } else {
      detailButtonState[2].value = false;
    }
  }

  void goMapToSelectedStore(int index) async {
    final storeIndex = stores
        .indexWhere((store) => store.storeId == searchStores[index].storeId);
    selectedTabIndex.value = Tabs.nmap;
    map.nmapController = Completer();
    showDetailInformation(markers[storeIndex], {"height": null, "width": null});
  }

  void goMapToSelectedStoreAtBookMark(int index) async {
    final storeIndex = stores.indexOf(clientStoreBookMark[index]);
    selectedTabIndex.value = Tabs.nmap;
    map.nmapController = Completer();
    showDetailInformation(markers[storeIndex], {"height": null, "width": null});
  }

  Future<void> search() async {
    isLoading.value = true;
    isEnd.value = false;
    try {
      final location = await Geolocator.getCurrentPosition();
      Map<String, Object?> data;
      if (await hasLocationPermission()) {
        data = {
          "uid": auth.user.value!.uid,
          "search_txt": searchText.text,
          "user_lat": location.latitude,
          "user_lng": location.longitude,
          "page": searchListPage.value
        };
      } else {
        data = {
          "uid": auth.user.value!.uid,
          "search_txt": searchText.text,
          "page": searchListPage.value
        };
      }
      final res = await api.dio.get('/store/list', queryParameters: data);

      final List<dynamic>? storeData = res.data['payload']['result'];
      if (storeData != null) {
        searchStores.value =
            storeData.map((map) => StoreModel.fromJson(map)).toList();
      }
      if (res.data['payload']['isEnd']) {
        isEnd.value = true;
        searchListPage.value = 1;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    isLoading.value = false;
  }

  /// 즐겨찾기 버튼 누를 시에 추가, 삭제, 교체가 일어나는 함수
  void updateBookMark(StoreModel? store) async {
    isLoading.value = true;
    try {
      final data = {"store_id": store!.storeId, "uid": auth.user.value!.uid};
      Dio.Response res;

      if (detailButtonState[1].value) {
        res = await api.dio.delete('/store/bookMark', data: data);
        clientStoreBookMark.remove(store);
      } else {
        res = await api.dio.post('/store/bookMark', data: data);
        clientStoreBookMark.add(store);
      }
      //성공 시
      if (res.statusCode == 200 || res.statusCode == 201) {
        detailButtonState[1].value = !detailButtonState[1].value;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "즐겨찾기 업데이트가 실패하였습니다.");
      Logger().e(e.toString());
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  void updateLikedStore(StoreModel? store) async {
    isLoading.value = true;
    try {
      final data = {"store_id": store!.storeId, "uid": auth.user.value!.uid};
      Dio.Response res;

      if (detailButtonState[2].value) {
        res = await api.dio.delete('/store/recommend', data: data);
        likeStoreCount.value = res.data['payload']['totalRecommend'];
        clientLikedStore.remove(store);
      } else {
        res = await api.dio.post('/store/recommend', data: data);
        likeStoreCount.value = res.data['payload']['totalRecommend'];
        clientLikedStore.add(store);
      }
      // 성공 시
      if (res.statusCode == 200 || res.statusCode == 201) {
        detailButtonState[2].value = !detailButtonState[2].value;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "좋아요 업데이트가 실패하였습니다.");
      Logger().e(e.toString());
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  Future<void> addSearch() async {
    isGetMoreData.value = true;
    try {
      final location = await Geolocator.getCurrentPosition();
      Map<String, Object?> data;
      if (await hasLocationPermission()) {
        data = {
          "uid": auth.user.value!.uid,
          "search_txt": searchText.text,
          "user_lat": location.latitude,
          "user_lng": location.longitude,
          "page": searchListPage.value
        };
      } else {
        data = {
          "uid": auth.user.value!.uid,
          "search_txt": searchText.text,
          "page": searchListPage.value
        };
      }
      final res = await api.dio.get('/store/list', queryParameters: data);

      final List<dynamic>? storeData = res.data['payload']['result'];
      if (storeData != null) {
        searchStores +=
            storeData.map((map) => StoreModel.fromJson(map)).toList();
      }
      if (res.data['payload']['isEnd']) {
        isEnd.value = true;
        searchListPage.value = 1;
      }
    } catch (e) {
      Logger().e(e.toString());
      isGetMoreData.value = false;
    }
    isGetMoreData.value = false;
  }

  ///북마크 list 정보 API
  Future<void> getClientStoreBookMark() async {
    try {
      for (var elem in stores) {
        if (elem.bookmarkYn == 1) {
          clientStoreBookMark.add(elem);
        }
        if (elem.isRecommendYn == 1) {
          clientLikedStore.add(elem);
        }
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  Future<void> getPopups() async {
    final res = await api.dio.post('/popup');

    final List<dynamic> data = res.data['payload']['popup'];
    final List<PopupModel> popups =
        data.map((e) => PopupModel.fromJson(e)).toList();

    List<dynamic> cachedNoShowPopupList =
        appData.read(StorageKeys.noShowPopupIdList) ?? [];

    final noShowPopupIdList = cachedNoShowPopupList.cast<int>().toList();

    for (final popup in popups) {
      final index = noShowPopupIdList.indexOf(popup.popupId!);

      if (index != -1) {
        continue; //for in 문 종료
      }

      Get.bottomSheet(
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 45,
                      height: 45,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxHeight: Get.height - 45),
                    child: Image.network(
                      '${popup.fileUrl}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(GapSize.xSmall),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              onPressed: () {
                                noShowPopupIdList.add(popup.popupId!);
                                appData.write(
                                  StorageKeys.noShowPopupIdList,
                                  noShowPopupIdList,
                                );
                                Get.back();
                              },
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: popup.bgColor),
                              child: Text(
                                '다시보지 않기',
                                style: TextStyle(
                                    color: popup.fontColor,
                                    fontFamily: "NotoB"),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: GapSize.xSmall),
                            child: OutlinedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: popup.bgColor),
                                child: Text(
                                  '닫기',
                                  style: TextStyle(
                                      color: popup.fontColor,
                                      fontFamily: "NotoB"),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          isScrollControlled: true,
          barrierColor: Colors.transparent);
    }
  }

  void signOut() {
    auth.signOut();
    Get.offAllNamed(Routes.login);
  }
}

enum Tabs {
  home,
  search,
  nmap,
  board,
  setting;

  String get routeString {
    switch (this) {
      case Tabs.home:
        return Routes.home;
      case Tabs.search:
        return Routes.search;
      case Tabs.nmap:
        return Routes.nmap;
      case Tabs.board:
        return Routes.board;
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
        return Tabs.board;
      case 4:
        return Tabs.setting;
      default:
        return Tabs.home;
    }
  }
}
