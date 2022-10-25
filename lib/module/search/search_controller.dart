import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/map_func.dart';
import 'package:oru_rock/model/store_model.dart';
import 'package:oru_rock/module/home/home_controller.dart';
import 'package:oru_rock/routes.dart';

class SearchController extends GetxController {
  final api = Get.find<ApiFunction>();
  final map = Get.find<MapFunction>();
  final home = Get.find<HomeController>();
  TextEditingController searchText = TextEditingController();
  var stores = <StoreModel>[].obs; //store 관리
  var isLoading = false.obs;

  @override
  void onInit() async {
    Get.find<MapFunction>().completer = Completer();
    stores.value = home.stores.value;
  }

  void goMapToSelectedStore(int index) async {
    Get.back();
    Get.toNamed(Routes.nmap);
    home.showDetailInformation(
        home.markers[index], {"height": null, "width": null});
    map.setCamera(home.markers[index].position!, 18.0);
  }

  Future<void> search() async {
    isLoading.value = true;
    try {
      final data = {"search_txt": searchText.text};
      final res = await api.dio.get('/store/list', queryParameters: data);

      final List<dynamic>? storeData = res.data['payload']['result'];
      if (storeData != null) {
        stores.value =
            storeData.map((map) => StoreModel.fromJson(map)).toList();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    isLoading.value = false;
  }
}
