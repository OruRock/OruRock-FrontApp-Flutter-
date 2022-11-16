import 'dart:io';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/login/login_controller.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => AnimateGradient(
            primaryBegin: Alignment.topLeft,
            primaryEnd: Alignment.bottomLeft,
            secondaryBegin: Alignment.bottomRight,
            secondaryEnd: Alignment.topRight,
            primaryColors: [
              Color(0xFFADA996),
              Color(0xFFf2f2f2),
              Color(0xFFdbdbdb),
              Color(0xFFeaeaea),
            ],
            secondaryColors: [
              Color(0xFFeaeaea),
              Color(0xFFdbdbdb),
              Color(0xFFf2f2f2),
              Color(0xFFADA996),
            ],
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: HeightWithRatio.xSmall,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GapSize.medium, vertical: GapSize.medium),
                      width: Get.width,
                      height: Get.height * 0.4,
                      child: AnimatedOpacity(
                          opacity: controller.opacityValue.value,
                          curve: Curves.easeIn,
                          duration: const Duration(seconds: 3),
                          child: Image.asset(
                            'asset/image/logo/app_logo.png',
                          )),
                    ),
                    SizedBox(
                      height: HeightWithRatio.xxxxSmall,
                    ),
/*                  const Align(
                        alignment: Alignment.center,
                        child: Text(
                          '오늘도 새로운 암장으로 떠나볼까요?',
                          style: TextStyle(
                              fontFamily: "NanumEB",
                              fontSize: FontSize.xxxLarge,
                              height: 1.5),
                        )),*/

                    const SizedBox(
                      height: GapSize.small,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: HeightWithRatio.xxSmall),
                        width: Get.width * 0.9,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            )
                          ],
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(RadiusSize.large)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '소셜 로그인',
                                  style: boldNanumTextStyle,
                                )),
                            const SizedBox(
                              height: GapSize.small,
                            ),
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: GapSize.xxSmall),
                                child: Center(
                                  child: SizedBox(
                                    height: 40,
                                    width: 280,
                                    child: SignInButton(
                                      Buttons.Google,
                                      text: 'Google 계정으로 로그인',
                                      onPressed: () => controller
                                          .loginButtonPressed('Google'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: GapSize.xxSmall),
                                child: Center(
                                  child: SizedBox(
                                    height: 40,
                                    width: 280,
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
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: GapSize.small),
                      child: Text(
                        '@ Developed by Team Oru_rock',
                        style: TextStyle(
                            color: Colors.black87, fontSize: FontSize.small),
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
            width: 280,
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
