import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/login/login_controller.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: GapSize.medium, vertical: GapSize.medium),
                child: Column(
                  children: [
                    const Image(
                        image: AssetImage('asset/image/logo/app_logo.png')),
                    SizedBox(
                      height: HeightWithRatio.xxxxSmall,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '오늘도 새로운 암장으로\n떠나볼까요?',
                          style: TextStyle(
                              fontFamily: "NanumEB",
                              fontSize: FontSize.xxxLarge,
                              height: 1.5),
                        )),
                    SizedBox(
                      height: HeightWithRatio.xSmall,
                    ),
                    Visibility(
                      visible: Platform.isAndroid,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: GapSize.xxSmall),
                        child: Center(
                          child: SizedBox(
                            height: HeightWithRatio.xSmall,
                            width: WidthWithRatio.xxxxLarge,
                            child: SignInButton(
                              Buttons.Google,
                              text: 'Google 계정으로 로그인',
                              onPressed: () =>
                                  controller.loginButtonPressed('Google'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: Platform.isIOS,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: GapSize.xxSmall),
                        child: Center(
                          child: SizedBox(
                            height: HeightWithRatio.xSmall,
                            width: WidthWithRatio.xxxxLarge,
                            child: SignInButton(Buttons.AppleDark,
                                text: 'Apple 계정으로 로그인', onPressed: () {
                              controller.loginButtonPressed('Apple');
                            }),
                          ),
                        ),
                      ),
                    ),
                    _buildLoginButton(
                        () => controller.loginButtonPressed('Kakao'),
                        'asset/image/logo/kakao_login.png'),
                    Expanded(child: Container()),
                    Text(
                      '@ Developed by Team Oru_rock',
                      style: TextStyle(
                          color: Colors.grey[400], fontSize: FontSize.small),
                    ),
                  ],
                ),
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
      ),
    );
  }

  Widget _buildLoginButton(Function() onPressed, String image) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: GapSize.xxSmall),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: HeightWithRatio.xSmall,
            width: WidthWithRatio.xxxxLarge,
            child: GestureDetector(
              onTap: onPressed,
              child: Image.asset(image),
            ),
          ),
        ],
      ),
    );
  }
}
