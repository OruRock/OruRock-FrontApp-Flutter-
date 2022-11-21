import 'dart:async';

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

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

  ///목적지 좌표 넣어주면 현 위치에서 목적지 좌표로 가는 네이버 지도 길찾기 기능으로 연결
  linkNaverMapNavigate(LatLng position, String storeName) async {
    await launchUrl(Uri.parse('nmap://route/public?dlat=${position.latitude}&dlng=${position.longitude}&dname=${Uri.encodeComponent(storeName)}&appname=com.orurock.ai.oru_rock'));
  }

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
