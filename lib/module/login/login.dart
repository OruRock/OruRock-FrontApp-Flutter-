import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/login/login_controller.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Image(image: AssetImage('images/Logo.png')),
          const Text('가입하기'),
          _buildLoginButton(() =>
              controller.kakaoLoginButtonPressed(),
              'images/kakao_login.png'),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: GapSize.xLarge),
                    child: SignInButton(
                      Buttons.Google,
                      text: 'Sign In Google',
                      onPressed: () => controller.googleLoginButtonPressed(),
                    ),
                  ),

              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton(Function() onPressed, String image) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: GapSize.small),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0X50606060),
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(0, 1.5),
                ),
              ],
              borderRadius: BorderRadius.circular(RadiusSize.small),
            ),
            child: Expanded(
              child: GestureDetector(
                onTap: onPressed,
                child: Image.asset(image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
