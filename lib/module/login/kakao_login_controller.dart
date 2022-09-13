import 'dart:developer';

import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoLoginController extends GetxController {
  void KakaoLoginButtonPressed() async {

    // 웹으로 로그인
    String authCode = await AuthCodeClient.instance.request();

    print(authCode);
  }
}