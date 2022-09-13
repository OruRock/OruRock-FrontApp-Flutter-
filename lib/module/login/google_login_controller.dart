import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oru_rock/model/login_user_model.dart';

class GoogleLoginController extends GetxController {
  static GoogleLoginController get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late User? currentUser;

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

    final credential = GoogleAuthProvider.credential(
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

  void signOut() async{
    await _auth.signOut();
    await googleSignIn.signOut();

    manager.user = UserData(name: "", email: "");
  }
}