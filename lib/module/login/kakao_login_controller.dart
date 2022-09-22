import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KakaoLoginController extends GetxController {
  var _isKakaoTalkInstalled = false;

  @override
  void onInit() {
    super.onInit();
    _initKakaoTalkInstalled();
  }

  void _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    _isKakaoTalkInstalled = installed;
  }

  Future<void> KakaoLoginButtonPressed() async {
    OAuthToken authCode;
    // 웹으로 로그인
    if (_isKakaoTalkInstalled) {
      try {
        authCode = await UserApi.instance.loginWithKakaoTalk();
        await _issueAccessToken(authCode);
      } catch (error) {
        Fluttertoast.showToast(
            msg: 'KakaoApp Login Fail',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1
        );
      }
    } else {
      try {
        authCode = await UserApi.instance.loginWithKakaoAccount();
        await _issueAccessToken(authCode);
      } catch (error) {
        Fluttertoast.showToast(
            msg: 'KakaoWeb Login Fail',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1
        );
      }
    }
  }

  _issueAccessToken(OAuthToken authCode) async {
    print("여기 ${authCode.accessToken}");

    // print('회원 정보 : ${tokenInfo.id}'
    //     '\n만료 시간 : ${tokenInfo.expiresIn}'
    //     '\n로그인 성공 : ${authCode.accessToken}');
  }
}