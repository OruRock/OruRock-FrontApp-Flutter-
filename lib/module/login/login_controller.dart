import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:oru_rock/model/login_user_model.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initKakaoTalkInstalled();
  }

  var _isKakaoTalkInstalled = false;

  //Kakao
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
            timeInSecForIosWeb: 1);
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
            timeInSecForIosWeb: 1);
      }
    }
  }

  _issueAccessToken(OAuthToken authCode) async {
    print("여기 ${authCode.accessToken}");

    // print('회원 정보 : ${tokenInfo.id}'
    //     '\n만료 시간 : ${tokenInfo.expiresIn}'
    //     '\n로그인 성공 : ${authCode.accessToken}');
  }

  //Google
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late firebase_auth.User? currentUser;

  final manager = UserManager();

  void GoogleLoginButtonPressed() async {
    if (manager.user?.name == null || manager.user!.name!.isEmpty)
      signIn();
    else
      signOut();
  }

  void signIn() async {
    final account = await googleSignIn.signIn();
    final googleAuth = await account?.authentication;

    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final authResult = await _auth.signInWithCredential(credential);
    final user = authResult.user;

    assert(user != null, "Google Login Failure");
    assert(await user?.getIdToken() != null);

    currentUser = await _auth.currentUser;

    assert(user!.uid == currentUser!.uid);

    manager.user = UserData(name: user?.displayName, email: user?.email);
  }

  void signOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();

    manager.user = UserData(name: "", email: "");
  }
}
