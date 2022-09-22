import 'dart:async';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/model/store_model.dart';

class NMapController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  Completer<NaverMapController> completer = Completer();
  MapType mapType = MapType.Basic;
  LocationTrackingMode trackingMode = LocationTrackingMode.Follow;

  var stores = <StoreModel>[].obs;

  RxList<Marker> markers = <Marker>[].obs;
  final api = Get.find<ApiFunction>();

  //controller가 init될 때 실행하는 함수
  @override
  void onInit() async {
    await getStoreList();
    setMarker();
    super.onInit();
  }

  onMapTap(LatLng position) async {
    Get.showSnackbar(GetBar(
      duration: const Duration(milliseconds: 1500),
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.GROUNDED,
      title: '터치한 위치',
      message: '[onTap] lat: ${position.latitude}, lon: ${position.longitude}',
    ));
  }

  //지도가 만들어지고 나서 일어나는 함수
  void onMapCreated(NaverMapController controller) {
    if (completer.isCompleted) completer = Completer();
    completer.complete(controller);
    goToMyLocation();
    setMarker();
  }

  //처음 켰을 때 내 현위치로 이동
  void goToMyLocation() async {
    final nmapController = await completer.future;
    nmapController.setLocationTrackingMode(LocationTrackingMode.Follow);
  }

  Future<void> getStoreList() async {
    try{
      final res = await api.dio.get('/store/list');

      final List<dynamic>? data = res.data['payload']['result'];
      if (data != null) {
        stores.value = data.map((map) => StoreModel.fromJson(map)).toList();
      }
    }catch(e){
      logger.e(e.toString());
    }
  }

  //마커 만들기
  void setMarker() async {
    for (var elem in stores) {
      markers.add(
        Marker(
            markerId: elem.storeId.toString(),
            position: LatLng(double.parse(elem.storeLat!), double.parse(elem.storeLag!))
        )
      );
    }
  }
}
