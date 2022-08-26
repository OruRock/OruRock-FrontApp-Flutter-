import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/model/geocoding_model.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;

class NMapController extends GetxController {
  Completer<NaverMapController> completer = Completer();
  MapType mapType = MapType.Basic;
  LocationTrackingMode trackingMode = LocationTrackingMode.Follow;
  RxList<Marker> markers = <Marker>[].obs;
  final api = Get.find<ApiFunction>();
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
    final nmapController = await completer.future;
    LatLng position = await getLatLngWithAddress("address");

    markers.add(Marker(
      markerId: "ClimbingStore",
      position: position,
      infoWindow: '테스트',
    ));

    final cameraPosition = CameraUpdate.scrollWithOptions(
        LatLng(position.latitude, position.longitude),
        zoom: 18);

    nmapController.moveCamera(cameraPosition);
  }

  LatLng getLatLng(double entX, double entY) {
    //Naver지도는 EPSG:3857로 좌표계 변환을 하여 아래와 같이 proj4 라이브러리로 일반 WSG84 좌표계로 변환이 가능하다. (반대로도 가능)

    final coord_X = (entX * 1000000).round() / 1000000;
    final coord_Y = (entY * 1000000).round() / 1000000;

    var pointDst = proj4.Point(x: coord_X, y: coord_Y);

    var projSrc = proj4.Projection.get('EPSG:4326')!;
    var projDst = proj4.Projection.get('EPSG:3857')!;

    var point = projDst.transform(projSrc, pointDst);

    return LatLng(point.y, point.x);
  }

  Future<LatLng> getLatLngWithAddress(String address) async {
    final data = {"query": "분당구 불정로 6"};

    //기본 baseUrl이 아닌 다른 Url의 Api를 사용하게 된다면 따로 header값 분기로 하므로 지정해주어야한다.
    final res = await dio.get(
        'https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode',
        options: Options(headers: api.naverApiHeaders),
        queryParameters: data);

    GeocodingModel geocodingModel = GeocodingModel.fromJson(res.data);

    return LatLng(double.parse(geocodingModel.addresses![0].y!),
        double.parse(geocodingModel.addresses![0].x!));
  }
}
