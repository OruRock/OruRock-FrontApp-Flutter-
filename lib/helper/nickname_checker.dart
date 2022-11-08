import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:oru_rock/function/api_func.dart';

Future<bool> nickNameChecker(String nickname) async {
  final api = Get.find<ApiFunction>();

  RegExp nickNameRegexp = RegExp(r'^[가-힣a-zA-Z0-9]{2,10}$');
  if (nickNameRegexp.hasMatch(nickname)) {
    final res = await api.dio
        .get('/nickName', queryParameters: {"user_nickname": nickname});
    if (res.data['payload']['value']) {
      return true;
    }
    Fluttertoast.showToast(msg: "중복된 닉네임입니다.");
    return false;
  }
  Fluttertoast.showToast(msg: "닉네임이 형식에 맞지 않습니다.");
  return false;
}
