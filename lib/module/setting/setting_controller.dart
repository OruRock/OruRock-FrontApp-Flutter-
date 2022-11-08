import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/function/map_func.dart';
import 'package:oru_rock/helper/nickname_checker.dart';
import 'package:oru_rock/routes.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:oru_rock/model/store_detail_model.dart';

class SettingController extends GetxController {
  final api = Get.find<ApiFunction>();
  final map = Get.find<MapFunction>();
  final auth = Get.find<AuthFunction>();
  var nickname = ''.obs;
  final nicknameController = TextEditingController();
  List<String> levelImage = [
    'asset/image/icon/profile/level_red.png',
    'asset/image/icon/profile/level_orange.png',
    'asset/image/icon/profile/level_yellow.png',
    'asset/image/icon/profile/level_green.png',
    'asset/image/icon/profile/level_blue.png',
    'asset/image/icon/profile/level_navy.png',
    'asset/image/icon/profile/level_purple.png',
    'asset/image/icon/profile/level_white.png',
    'asset/image/icon/profile/level_grey.png',
    'asset/image/icon/profile/level_black.png',
    'asset/image/icon/profile/level_master.png',
  ];
  final userLevel = 0.obs;
  var isLoading = false.obs;
  var appVersion = ''.obs;
  var myReviewList = <Comment>[].obs;

  @override
  void onInit() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setNicknameAtUserModel();
    userLevel.value = auth.user!.userLevel!;
    appVersion.value = packageInfo.version;
  }

  void signOut() {
    auth.signOut();
    Get.offAllNamed(Routes.login);
  }

  Future<void> changeNickname() async {
    isLoading.value = true;
    final changeNickname = nicknameController.text.trim();
    try {
      if (!await nickNameChecker(changeNickname)) {
        isLoading.value = false;
        return;
      }

      final data = {
        "uid": auth.user!.uid,
        "user_email": auth.user!.email,
        "user_nickname": changeNickname
      };

      final res = await api.dio.post('/user', data: data);

      if (res.statusCode == 200 || res.statusCode == 201) {
        auth.user!.displayName = changeNickname;
        setNicknameAtUserModel();
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

  void setNicknameAtUserModel() {
    nickname.value = auth.user!.displayName!;
  }

  void setUserLevel(int index) async {
    isLoading.value = true;
    try {
      final data = {
        "uid": auth.user!.uid,
        "user_email": auth.user!.email,
        "user_level": index
      };

      final res = await api.dio.post('/user', data: data);

      if (res.statusCode == 200 || res.statusCode == 201) {
        auth.user!.userLevel = index;
        userLevel.value = index;
      }
    } catch (e) {
      Logger().e(e.toString());
      isLoading.value = false;
      return;
    }
    isLoading.value = false;
    Get.back();
    Fluttertoast.showToast(msg: "프로필 설정이 완료되었습니다.");
  }

  Future<List<Comment>> getMyReview() async {
    List<Comment> comment = [];
    try {
      final data = {"uid": auth.user?.uid, "page": 1};
      final res = await api.dio.get('/store/myReview', queryParameters: data);

      final List<dynamic>? reviewData = res.data['payload']['result'];
      if (reviewData != null) {
        comment = reviewData.map((map) => Comment.fromJson(map)).toList();
        return comment;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return comment;
  }



  Future<void> removeCommentAtMyReview(Comment comment) async {
    final data = {"comment_id": comment.commentId.toString(), "uid": auth.user!.uid};
    final res = await api.dio.delete('/store/comment', queryParameters: data);
    if(res.statusCode == 200 || res.statusCode == 201) {
      myReviewList.remove(comment);
      Fluttertoast.showToast(msg: "선택하신 리뷰가 삭제되었습니다.");
      return;
    }
    Fluttertoast.showToast(msg: "리뷰 삭제에 실패하였습니다.");
  }
}
