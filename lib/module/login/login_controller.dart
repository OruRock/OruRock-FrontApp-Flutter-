import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void KakaoLoginButtonPressed() async {
    String authCode = await AuthCodeClient.instance.request();
    print(authCode);
  }
}