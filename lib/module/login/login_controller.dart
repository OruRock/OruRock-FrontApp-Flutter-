import 'package:get/get.dart';
import 'package:oru_rock/module/login/kakao_login_controller.dart';
import 'package:oru_rock/module/login/google_login_controller.dart';

class LoginController extends GetxController {

  void a(String tag) async {
    switch(tag) {
      case "kakao":
        KakaoLoginController().KakaoLoginButtonPressed();
        break;
      case "google":
        GoogleLoginController().GoogleLoginButtonPressed();
        break;
      default:
        print("error in controller switch");
    }
  }
}