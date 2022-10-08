import 'dart:async';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/function/map_func.dart';
import 'package:oru_rock/module/home/home_controller.dart';

class NMapController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  final map = Get.find<MapFunction>();
  final home = Get.find<HomeController>();

  //controller가 init될 때 실행하는 함수
  @override
  void onInit() async {
    Get.find<MapFunction>().completer = Completer();
    super.onInit();
  }
}
