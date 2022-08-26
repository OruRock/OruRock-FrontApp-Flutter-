import 'dart:async';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class NMapController extends GetxController {
  Completer<NaverMapController> completer = Completer();
  MapType mapType = MapType.Basic;
  LocationTrackingMode trackingMode = LocationTrackingMode.Follow;
  RxList<Marker> markers = <Marker>[].obs;
  SolidController solidController = SolidController();

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
    markers.removeLast();
  }
  void onMapCreated(NaverMapController controller) {
    if (completer.isCompleted) completer = Completer();
    completer.complete(controller);
    goToMyLocation();
  }

  void goToMyLocation() async {
    final nmapController = await completer.future;
    nmapController.setLocationTrackingMode(LocationTrackingMode.Follow);
  }

  void goToSelectedLocation(LatLng position) async {
    final nmapController = await completer.future;
    markers.add(Marker(
      markerId: DateTime.now().toIso8601String(),
      position: position,
      infoWindow: '테스트',
    ));
    final cameraPosition = CameraUpdate.scrollWithOptions(
        LatLng(position.latitude, position.longitude),
        zoom: 18);
    nmapController.moveCamera(cameraPosition);
  }

}
