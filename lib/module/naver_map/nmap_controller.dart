import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/model/geocoding_model.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;

class NMapController extends GetxController {
  Completer<NaverMapController> completer = Completer();
  MapType mapType = MapType.Basic;
  LocationTrackingMode trackingMode = LocationTrackingMode.Follow;
  RxList<Marker> markers = <Marker>[].obs;
  final api = Get.find<ApiFunction>();
  final userAuth = Get.find<AuthFunction>();
  var dio = Dio();

  //controller가 init될 때 실행하는 함수
  @override
  void onInit() async {
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

  //마커 만들기
  void setMarker() async {
    final data = {
      "user_email" : userAuth.user?.email,
      "user_nickname" : userAuth.user?.displayName,
    };
    final res = await api.dio.get('/store/list', queryParameters: data);
    print(res.data);
  }

}
