class LoginResult {
  final LoginStatus status;

  LoginResult({
    required this.status,
  });
}

enum LoginStatus { newUser, existUser, failed }
