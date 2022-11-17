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

String? Function(String? value) validateComment() {
  return (String? value) {
    value = value?.trim();
    if (value!.isEmpty) {
      return "댓글은 공백이 들어갈 수 없습니다.";
    } else if (value.length < 0 ) {
      return "댓글은 1글자 이상 입력해주세요.";
    } else {
      return null;
    }
  };
}

Function validateTitle() {
  return (String? value) {
    value = value?.trim();
    if (value!.isEmpty) {
      return "제목은 공백이 들어갈 수 없습니다.";
    } else if (value.length > 30) {
      return "제목의 길이를 초과하였습니다.";
    } else {
      return null;
    }
  };
}

Function validateContent() {
  return (String? value) {
    value = value?.trim();
    if (value!.isEmpty) {
      return "내용은 공백이 들어갈 수 없습니다.";
    } else if (value.length > 500) {
      return "내용의 길이를 초과하였습니다.";
    } else if (value.length < 10) {
      return "본문은 10글자 이상 입력해주세요.";
    } else {
      return null;
    }
  };
}


