import 'package:get/get.dart';

class UserModel {
  String? uid;
  String? userEmail;
  int? userId;
  int? useYn;
  RxString? userNickname;
  RxString? userHeight;
  RxString? userReach;
  RxString? instaNickname;
  RxInt? userLevel;
  String? createDate;
  String? updateDate;

  UserModel(
      {this.uid,
        this.userEmail,
        this.userId,
        this.useYn,
        this.userNickname,
        this.userHeight,
        this.userReach,
        this.instaNickname,
        this.userLevel,
        this.createDate,
        this.updateDate});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userEmail = json['user_email'];
    userId = json['user_id'];
    useYn = json['use_yn'];
    userNickname = json['user_nickname'].toString().obs;
    userHeight = json['user_height'] != null ? json['user_height'].toString().obs : '없음'.obs;
    userReach = json['user_reach'] != null ? json['user_reach'].toString().obs : '없음'.obs;
    instaNickname = json['insta_nickname'].obs;
    userLevel = int.parse(json['user_level'].toString()).obs;
    createDate = json['create_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['user_email'] = userEmail;
    data['user_id'] = userId;
    data['use_yn'] = useYn;
    data['user_nickname'] = userNickname;
    data['user_height'] = userHeight;
    data['user_reach'] = userReach;
    data['insta_nickname'] = instaNickname;
    data['user_level'] = userLevel;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    return data;
  }
}
