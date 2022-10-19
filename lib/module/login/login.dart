import 'dart:ui';

import 'package:flutter/material.dart';
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
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                const Image(image: AssetImage('asset/image/logo/Logo.png')),
                _buildLoginButton(() => controller.kakaoLoginButtonPressed(),
                    'asset/image/logo/kakao_login.png'),
                Center(
                  child: SizedBox(
                    width: WidthWithRatio.xxxxLarge,
                    height: HeightWithRatio.xSmall,
                    child: SignInButton(
                      Buttons.Google,
                      text: 'Sign In Google',
                      onPressed: () => controller.googleLoginButtonPressed(),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
                visible: controller.isLoading.value,
                child: Container(
                  color: Colors.grey.withOpacity(0.3),
                  height: Get.height,
                  width: Get.width,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
          ],
        ),
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
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 1,
                  spreadRadius: 0.5,
                  offset: const Offset(0, 1.5),
                ),
              ],
              borderRadius: BorderRadius.circular(RadiusSize.small),
            ),
            child: SizedBox(
              width: WidthWithRatio.xxxxLarge,
              height: HeightWithRatio.xSmall,
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
