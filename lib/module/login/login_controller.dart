import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void KakaoLoginButtonPressed() async {
    String authCode = await AuthCodeClient.instance.request();
    print(authCode);
  }

  Future<UserCredential> GoogleLoginButtonPressed() async {
    final GoogleSignInAccount? account = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await account?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}