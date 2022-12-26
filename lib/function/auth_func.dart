import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/constant/storagekey.dart';
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
  Rx<UserModel?> user = UserModel().obs;

  setJwt(String jwt) {
    this.jwt = jwt;
  }

  setUser(dynamic userJson) {
    user.value = UserModel.fromJson(userJson);
  }

  signOut() {
    jwt = '';
    user.value = null;
    appData.remove("UID");
    appData.remove(StorageKeys.pin);
  }
}
