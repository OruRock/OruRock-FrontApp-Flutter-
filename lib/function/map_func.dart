import 'dart:async';

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

///지도와 관련된 함수를 관리하는 Service
class MapFunction extends GetxService {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );
  Completer<NaverMapController> nmapController = Completer();
  MapType mapType = MapType.Basic;
  LocationTrackingMode trackingMode = LocationTrackingMode.Follow;

  Future<MapFunction> init() async {
    return this;
  }

  onMapTap(LatLng position) async {}

  //지도가 만들어지고 나서 일어나는 함수
  void onMapCreated(NaverMapController controller) async {
    if (nmapController.isCompleted) nmapController = Completer();
    nmapController.complete(controller);
  }

/*  //처음 켰을 때 내 현위치로 이동
  void goToMyLocation() async {
    final nmapController = await completer.future;
    nmapController.setLocationTrackingMode(LocationTrackingMode.Follow);
  }*/

  ///[position]으로 카메라 위치 이동 후 [zoom]만큼 확대
  void setCamera(LatLng position, double zoom) async {
    try {
      final controller = await nmapController.future;

      final cameraPosition =
          CameraUpdate.scrollWithOptions(position, zoom: zoom);
      await controller.moveCamera(cameraPosition);
    } catch (e) {
      print(e.toString());
    }
  }
}
