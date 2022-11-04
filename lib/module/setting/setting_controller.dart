import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/function/map_func.dart';
import 'package:oru_rock/helper/nickname_checker.dart';
import 'package:oru_rock/routes.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingController extends GetxController {
  final api = Get.find<ApiFunction>();
  final map = Get.find<MapFunction>();
  final auth = Get.find<AuthFunction>();
  var nickname = ''.obs;
  final nicknameController = TextEditingController();
  var isLoading = false.obs;
  var appVersion = ''.obs;

  @override
  void onInit() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setNicknameAtUserModel();
    appVersion.value = packageInfo.version;
  }

  void signOut() {
    auth.signOut();
    Get.offAllNamed(Routes.login);
  }

  Future<void> changeNickname() async {
    isLoading.value = true;
    final changeNickname = nicknameController.text.trim();
    try {
      if(!nickNameChecker(changeNickname)) {
        Fluttertoast.showToast(msg: "닉네임이 부적절하거나 이미 사용중인 닉네임입니다.");
        isLoading.value = false;
        return;
      }

      final data = {
        "uid": auth.user!.uid,
        "user_email": auth.user!.email,
        "user_nickname": changeNickname
      };

      final res = await api.dio.post('/user', data: data);

      if(res.statusCode == 200 || res.statusCode == 201) {
        auth.user!.displayName = changeNickname;
        setNicknameAtUserModel();
      }
    } catch(e) {
      Logger().e(e.toString());
      isLoading.value = false;
      return;
    }
    isLoading.value = false;
    nicknameController.text = '';
    Get.back();
    Fluttertoast.showToast(msg: "닉네임 변경이 완료되었습니다.");
  }

  void setNicknameAtUserModel() {
    nickname.value = auth.user!.displayName!;
  }
}
