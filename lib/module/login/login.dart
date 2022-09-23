import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/login/login_controller.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _buildLoginButton(
              () => controller.KakaoLoginButtonPressed(), 'Kakao'),
          _buildLoginButton(
              () => controller.GoogleLoginButtonPressed(), 'Google'),
          _buildLoginButton(() {}, "Naver"),
        ],
      ),
    );
  }

  Widget _buildLoginButton(Function() onPressed, String login) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: GapSize.small),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(login),
      ),
    );
  }
}
