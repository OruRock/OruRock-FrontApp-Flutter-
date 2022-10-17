import 'dart:async';

import 'package:get/get.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/map_func.dart';
import 'package:oru_rock/module/home/home_controller.dart';
import 'package:oru_rock/routes.dart';

class SearchController extends GetxController {
  final api = Get.find<ApiFunction>();
  final map = Get.find<MapFunction>();
  final home = Get.find<HomeController>();

  @override
  void onInit() async {
    Get.find<MapFunction>().completer = Completer();
  }

  void goMapToSelectedStore(int index) async {
    Get.back();
    Get.toNamed(Routes.nmap);
    home.showDetailInformation(
        home.markers[index], {"height": null, "width": null});
    map.setCamera(home.markers[index].position!, 18.0);
  }
}
