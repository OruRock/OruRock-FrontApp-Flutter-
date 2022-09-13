class UserData {
  String? name = "";
  String? email = "";

  UserData({
    this.name,
    this.email
  });
}

class UserManager {
  UserData? _user = null;

  UserData? get user => _user;

  set user(UserData? user) {
    _user = user;
  }
}