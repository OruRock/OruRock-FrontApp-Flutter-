import 'dart:async';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;

class NMapController extends GetxController {
  Completer<NaverMapController> completer = Completer();
  MapType mapType = MapType.Basic;
  LocationTrackingMode trackingMode = LocationTrackingMode.Follow;
  RxList<Marker> markers = <Marker>[].obs;

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
  void onMapCreated(NaverMapController controller) {
    if (completer.isCompleted) completer = Completer();
    completer.complete(controller);
    goToMyLocation();
    setMarker();
  }

  void goToMyLocation() async {
    final nmapController = await completer.future;
    nmapController.setLocationTrackingMode(LocationTrackingMode.Follow);
  }

  void setMarker() async {
    final nmapController = await completer.future;
    LatLng position = getLatLng(14151561.7330666,4507202.5944991);

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

    final coord_X = (entX * 1000000).round()/ 1000000;
    final coord_Y = (entY * 1000000).round()/ 1000000;

    var pointDst = proj4.Point(x: coord_X, y: coord_Y);

    var projSrc = proj4.Projection.get('EPSG:4326')!;
    var projDst = proj4.Projection.get('EPSG:3857')!;

    var point = projDst.transform(projSrc, pointDst);
    print(point.x);
    print(point.y);
    return LatLng(point.y, point.x);
  }

}
