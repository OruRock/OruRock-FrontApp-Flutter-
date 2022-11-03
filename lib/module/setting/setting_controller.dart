
import 'package:get/get.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/function/map_func.dart';
import 'package:oru_rock/routes.dart';

class SettingController extends GetxController {
  final api = Get.find<ApiFunction>();
  final map = Get.find<MapFunction>();
  final auth = Get.find<AuthFunction>();

  @override
  void onInit() async {

  }
  void signOut() {
    auth.signOut();
    Get.offAllNamed(Routes.login);
  }
}
