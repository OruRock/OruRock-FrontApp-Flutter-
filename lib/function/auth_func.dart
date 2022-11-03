import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/model/user_model.dart';

class AuthFunction extends GetxService {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );
  final appData = GetStorage();

  Future<AuthFunction> init() async {
    return this;
  }

  String jwt = '';
  UserModel? user;

  setJwt(String jwt) {
    this.jwt = jwt;
  }

  setUser(String? displayName, String? email, String uid) {
    user = UserModel(displayName: displayName, email: email, uid: uid);
  }

  signOut() {
    jwt = '';
    user = null;
    appData.remove("UID");
    appData.remove("PIN");
  }
}
