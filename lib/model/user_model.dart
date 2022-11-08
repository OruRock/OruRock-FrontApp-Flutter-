class UserModel {
  String? displayName = "";
  String? email = "";
  String uid = "";
  int? userLevel;
  UserModel({this.displayName, this.email, required this.uid, required this.userLevel});
}

