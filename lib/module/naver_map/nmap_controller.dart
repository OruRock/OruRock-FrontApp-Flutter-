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
import 'package:oru_rock/module/home/home_controller.dart';
import 'package:oru_rock/module/marker_detail/marker_detail.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/model/geocoding_model.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;

class NMapController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  final api = Get.find<ApiFunction>();
  final map = Get.find<MapFunction>();
  final home = Get.find<HomeController>();
  final userAuth = Get.find<AuthFunction>();

  //controller가 init될 때 실행하는 함수
  @override
  void onInit() async {
    Get.find<MapFunction>().completer = Completer();
    super.onInit();
  }
}
