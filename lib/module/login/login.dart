import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/module/login/login_controller.dart';
import 'package:oru_rock/routes.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.offNamed(Routes.analysis);
          },
          child: const Text('첫 화면'),
        ),
      ),
    );
  }
}