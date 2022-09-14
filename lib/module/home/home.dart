import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/module/home/home_controller.dart';

import 'package:oru_rock/routes.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.offNamed(Routes.nmap);
          },
          child: const Text('첫 화면'),
        ),
      ),
    );
  }
}
