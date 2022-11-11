import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/helper/nickname_checker.dart';
import 'package:oru_rock/model/result_model.dart';
import 'package:oru_rock/model/user_model.dart';
import 'package:oru_rock/module/login/first_nickname.dart';
import 'package:oru_rock/routes.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController {
  final api = Get.find<ApiFunction>();
  final userAuth = Get.find<AuthFunction>();
  final appData = GetStorage();
  var isLoading = false.obs; //로그인중 로딩용
  final nicknameController = TextEditingController();

  var opacityValue = 0.0.obs;
  var opacityAnimateList = [0.0, 1.0];

  @override
  void onInit() async {
    super.onInit();
    await autoLogin();
  }

  @override
  void onReady() {
    opacityValue.value = opacityAnimateList[1];
  }

  ///로그인 버튼을 클릭했을 시 로그인 성공/실패를 따지는 함수
  void loginButtonPressed(String provider) async {
    isLoading.value = true;
    LoginResult success;

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
        success = LoginResult(status: LoginStatus.failed);
    }

    if (success.status == LoginStatus.existUser) {
      //로그인 성공시
      Get.offAllNamed(Routes.app);
      appData.write("UID", userAuth.user!.uid);
    } else if (success.status == LoginStatus.newUser) {
      Get.to(const FirstNickname());
      appData.write("UID", userAuth.user!.uid);
    } else {
      //로그인 실패시
      Logger().e("Login Failed");
    }
    isLoading.value = false;
  }

  //Kakao
  Future<LoginResult> signInWithKakao() async {
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
      };

      final kakao_res = await api.dio.post('/login/kakao', data: kakao_data);

      final data = {
        "uid": kakao_res.data['payload']['uid'],
        "user_email": user.kakaoAccount?.email,
      };

      final res = await api.dio.post('/login', data: data);

      userAuth.setJwt(res.data['payload']['result']);

      userAuth.setUser(
          res.data['payload']['user']['user_nickname'],
          user.kakaoAccount?.email,
          kakao_res.data['payload']['uid'],
          res.data['payload']['user']['user_level']);

      if (kakao_res.data['payload']['isNewUser']) {
        return LoginResult(status: LoginStatus.newUser);
      }
      return LoginResult(status: LoginStatus.existUser);
    } catch (e) {
      Logger().e(e.toString());
      return LoginResult(status: LoginStatus.failed);
    }
  }

  //Google
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late firebase_auth.User? currentUser;

  /// 구글 로그인을 처리하는 함수 유저 [uid]로 [jwt]을 API로 가져온다.
  /// [AuthFunction]에 [jwt]와 유저 정보[UserModel]를 저장한다.
  /// 성공한다면 [true] , 실패하면 [false]
  Future<LoginResult> signInWithGoogle() async {
    final account = await googleSignIn.signIn();

    if(account == null){
      return LoginResult(status: LoginStatus.failed);
    }
    final googleAuth = await account?.authentication;

    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final authResult = await _auth.signInWithCredential(credential);

    return await setUserAtUserModel(authResult);
  }

  //Apple
  Future<LoginResult> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'app.orurock.com',
          redirectUri: Uri.parse(
            'https://holistic-plausible-wood.glitch.me/callbacks/sign_in_with_apple',
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
      return LoginResult(status: LoginStatus.failed);
    }
  }

  Future<LoginResult> setUserAtUserModel(
      firebase_auth.UserCredential authResult) async {
    try {
      final user = authResult.user;
      currentUser = _auth.currentUser;

      if (user == null || user.uid != currentUser?.uid) {
        return LoginResult(status: LoginStatus.failed);
      }

      final data = {
        "uid": user.uid,
        "user_email": user.email,
      };

      final res = await api.dio.post('/login', data: data);

      userAuth.setJwt(res.data['payload']['result']);
      userAuth.setUser(
          res.data['payload']['user']['user_nickname'],
          res.data['payload']['user']['user_email'],
          user.uid,
          res.data['payload']['user']['user_level']);

      if (authResult.additionalUserInfo!.isNewUser) {
        return LoginResult(status: LoginStatus.newUser);
      }
      return LoginResult(status: LoginStatus.existUser);
    } catch (e) {
      Logger().e(e.toString());
      return LoginResult(status: LoginStatus.failed);
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
      userAuth.setUser(
          res.data['payload']['user']['user_nickname'],
          res.data['payload']['user']['user_email'],
          cachedUid,
          res.data['payload']['user']['user_level']);

      Get.offAllNamed(Routes.app);
    }
    isLoading.value = false;
  }

  Future<void> changeNickname() async {
    isLoading.value = true;
    final changeNickname = nicknameController.text.trim();
    try {
      if (!await nickNameChecker(changeNickname)) {
        Fluttertoast.showToast(msg: "닉네임이 부적절하거나 이미 사용중인 닉네임입니다.");
        isLoading.value = false;
        return;
      }

      final data = {
        "uid": userAuth.user!.uid,
        "user_email": userAuth.user!.email,
        "user_nickname": changeNickname
      };

      final res = await api.dio.post('/user', data: data);

      if (res.statusCode == 200 || res.statusCode == 201) {
        userAuth.user!.displayName = changeNickname;
        Get.offAllNamed(Routes.app);
      }
    } catch (e) {
      Logger().e(e.toString());
      isLoading.value = false;
      return;
    }
    isLoading.value = false;
    nicknameController.text = '';
    Get.back();
    Fluttertoast.showToast(msg: "닉네임 변경이 완료되었습니다.");
  }
}
