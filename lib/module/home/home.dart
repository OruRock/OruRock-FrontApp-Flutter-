import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/module/home/fragment/home_service_top.dart';
import 'package:oru_rock/module/home/home_controller.dart';
import 'package:oru_rock/routes.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            ElevatedButton(onPressed: (){
              controller.signOut();
            }, child: Text('로그아웃')),
            SizedBox(
              height: HeightWithRatio.medium,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: GapSize.medium),
              child: HomeServiceTop(),
            ),
            SizedBox(
              height: HeightWithRatio.medium,
              width: Get.width,
              child: const Center(child: Text('Admob Banner')),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: GapSize.medium),
              child: Text(
                '즐겨찾는 암장',
                style:
                    TextStyle(fontSize: FontSize.large, fontFamily: "NotoB"),
              ),
            ),
            const SizedBox(
              height: GapSize.medium,
            ),
            _buildListTile(),
            _buildListTile(),
            _buildListTile(),
            _buildListTile(),
            _buildListTile(),
            _buildListTile(),
            _buildListTile(),
          ],
        ),
      ),
    );
  }

  _buildListTile() {
    return const Center(
      child: ListTile(
        title: Text('암장 1'),
      ),
    );
  }
}
