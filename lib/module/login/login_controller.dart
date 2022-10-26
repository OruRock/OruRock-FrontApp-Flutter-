import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/model/user_model.dart';
import 'package:oru_rock/routes.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController {
  final api = Get.find<ApiFunction>();
  final userAuth = Get.find<AuthFunction>();
  final appData = GetStorage();
  var isLoading = false.obs; //로그인중 로딩용

  @override
  void onInit() async {
    super.onInit();
    await autoLogin();
  }

  ///로그인 버튼을 클릭했을 시 로그인 성공/실패를 따지는 함수
  void loginButtonPressed(String provider) async {
    isLoading.value = true;
    var success = false;

    switch (provider) {
      case 'Google':
        success = await signInWithGoogle();
        break;
      case 'Apple':
        success = await signInWithApple();
        break;
      case 'Kakao':
        success = await signInWithKakao();
        break;
      default:
        success = false;
    }

    if (success) {
      //로그인 성공시
      Get.offAllNamed(Routes.app);
      appData.write("UID", userAuth.user!.uid);
    } else {
      //로그인 실패시
      Logger().e("Login Failed");
    }
    isLoading.value = false;
  }

  //Kakao
  Future<bool> signInWithKakao() async {
    OAuthToken? authCode;
    // 앱으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        authCode = await UserApi.instance.loginWithKakaoTalk();
      } catch (error) {
        Fluttertoast.showToast(
            msg: 'KakaoApp Login Fail',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    } else {
      try {
        authCode = await UserApi.instance.loginWithKakaoAccount();
      } catch (error) {
        Fluttertoast.showToast(
            msg: 'KakaoWeb Login Fail',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    }

    User user;
    user = await UserApi.instance.me();

    try {
      final kakao_data = {
        "kakao_id": user.id.toString(),
        "email": user.kakaoAccount?.email,
        "displayName": user.kakaoAccount?.profile?.nickname
      };

      final kakao_res = await api.dio.post('/login/kakao', data: kakao_data);

      final data = {
        "uid": kakao_res.data['payload'][0],
        "user_email": user.kakaoAccount?.email,
        "user_nickname": user.kakaoAccount?.profile?.nickname,
      };

      final res = await api.dio.post('/login', data: data);

      userAuth.setJwt(res.data['payload']['result']);
      userAuth.setUser(user.kakaoAccount?.profile?.nickname,
          user.kakaoAccount?.email, kakao_res.data['payload'][0]);

      return true;
    } catch (e) {
      Logger().e(e.toString());
      return false;
    }
  }

  //Google
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late firebase_auth.User? currentUser;

  /// 구글 로그인을 처리하는 함수 유저 [uid]로 [jwt]을 API로 가져온다.
  /// [AuthFunction]에 [jwt]와 유저 정보[UserModel]를 저장한다.
  /// 성공한다면 [true] , 실패하면 [false]
  Future<bool> signInWithGoogle() async {
    final account = await googleSignIn.signIn();

    final googleAuth = await account?.authentication;

    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final authResult = await _auth.signInWithCredential(credential);

    return await setUserAtUserModel(authResult);
  }

  //Apple
  Future<bool> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.orurock.app',
          redirectUri: Uri.parse(
            'https://orurock-fa5dd.firebaseapp.com/callback.apple',
          ),
        ),
      );

      final oAuthProvider = firebase_auth.OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final authResult = await _auth.signInWithCredential(credential);

      return await setUserAtUserModel(authResult);
    } catch (e) {
      Logger().e(e.toString());
      return false;
    }
  }

  Future<bool> setUserAtUserModel(
      firebase_auth.UserCredential authResult) async {
    try {
      final user = authResult.user;
      currentUser = _auth.currentUser;

      if (user == null || user.uid != currentUser?.uid) {
        return false;
      }

      final data = {
        "uid": user.uid,
        "user_email": user.email,
        "user_nickname": user.displayName,
      };

      final res = await api.dio.post('/login', data: data);

      userAuth.setJwt(res.data['payload']['result']);
      userAuth.setUser(res.data['payload']['nick_name'], res.data['payload']['email'], user.uid);

      return true;
    } catch (e) {
      Logger().e(e.toString());
      return false;
    }
  }

  /// 구글 로그아웃 처리 + [AuthFunction]에서 관리하던 데이터 초기화
  /// 나중에 각 플랫폼마다 분기처리해서 한번에 통합해도 괜찮을 듯
  void signOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();
  }

  Future<void> autoLogin() async {
    isLoading.value = true;

    final cachedUid = appData.read("UID");

    if (cachedUid != null) {
      final data = {
        "uid": cachedUid,
      };

      final res = await api.dio.post('/login', data: data);

      userAuth.setJwt(res.data['payload']['result']);
      userAuth.setUser(res.data['payload']['nick_name'], res.data['payload']['email'], cachedUid);

      Get.offAllNamed(Routes.app);
    }
    isLoading.value = false;
  }
}
