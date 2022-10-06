import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oru_rock/module/home/home_controller.dart';

class MarkerDetailController extends GetxController {

  final home = Get.find<HomeController>();
  final appData = GetStorage();
  var pinned = false.obs;

  @override
  void onInit() async {

  }

  void isPinned() {
    if(home.selectedIndex == appData.read("PIN")) {
      pinned.value = true;
      return;
    }
    pinned.value = false;
  }

}
