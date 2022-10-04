import 'dart:async';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
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

  var isPinned = true.obs;
  var stores = <StoreModel>[].obs;
  var reviews = <StoreReviewModel>[].obs;

  Completer<NaverMapController> completer = Completer();
  RxList<Marker> markers = <Marker>[].obs;


  @override
  void onInit() async {
    await getStoreList();
    setMarker();
    super.onInit();
  }

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
    for (var elem in stores) {
      markers.add(Marker(
          markerId: elem.storeId.toString(),
          position: LatLng(
              double.parse(elem.storeLat!), double.parse(elem.storeLag!)),
          onMarkerTab: onMarkerTap));
    }
  }

  void onMarkerTap(Marker? marker, Map<String, int?> iconSize) async {
    getReviewList(int.parse(marker!.markerId));
    showStickyFlexibleBottomSheet(
      minHeight: 0,
      initHeight: 0.3,
      maxHeight: 1,
      barrierColor: Colors.transparent,
      bottomSheetColor: Colors.transparent,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 0), // changes position of shadow
          )
        ],
        color: Colors.white,
        borderRadius:
        const BorderRadius.vertical(top: Radius.circular(RadiusSize.large)),
      ),
      headerHeight: Get.height * 0.3,
      context: Get.context!,
      headerBuilder: (context, offset) {
        return MarkerDetail(
            store: stores[int.parse(marker!.markerId) - 1]);
      },
      isSafeArea: true,
      bodyBuilder: (context, offset) {
        return SliverChildListDelegate(List.generate(reviews.length, (index) {
          return ListTile(
            title: Text(reviews[index].userNickname!),
            subtitle: Text(reviews[index].comment!),
          );
        }));
      },
      anchors: [.3],
    );
    //Get.to(() => MarkerDetail(store: stores[int.parse(marker!.markerId) - 1]));
  }

  Future<void> getReviewList(int index) async {
    try {
      final reqData = {
        "store_id": index.toString(),
        "commentOnly": true,
      };

      final res = await api.dio.get('/store/detail', queryParameters: reqData);

      final List<dynamic>? data = res.data['payload']['comment'];
      if (data != null) {
        reviews.value =
            data.map((map) => StoreReviewModel.fromJson(map)).toList();
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }
}
