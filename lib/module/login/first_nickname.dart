import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/login/login_controller.dart';

class FirstNickname extends GetView<LoginController> {
  const FirstNickname({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '프로필 수정',
          ),
        ),
        body: Obx(
              () => controller.isLoading.value
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : SingleChildScrollView(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: WidthWithRatio.xSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: HeightWithRatio.xxSmall,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.person,
                        size: 18,
                      ),
                      SizedBox(
                        width: GapSize.xxxSmall,
                      ),
                      Text(
                        '닉네임',
                        style: TextStyle(
                            fontFamily: "NotoM",
                            fontSize: FontSize.small),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: GapSize.xSmall,
                  ),
                  TextField(
                    controller: controller.nicknameController,
                    decoration: InputDecoration(
                        filled: false,
                        hintText: controller.userAuth.user.value!.userNickname!.value,
                        hintStyle: const TextStyle(
                            fontSize: FontSize.large,
                            color: Colors.grey,
                            fontFamily: "NotoR"),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: GapSize.small,
                            horizontal: GapSize.small)),
                    style: const TextStyle(
                        fontSize: FontSize.large, fontFamily: "NotoR"),
                  ),
                  SizedBox(
                    height: HeightWithRatio.xxxxSmall,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        FontAwesomeIcons.instagram,
                        size: 18,
                      ),
                      SizedBox(
                        width: GapSize.xxxSmall,
                      ),
                      Text(
                        '인스타그램',
                        style: TextStyle(
                            fontFamily: "NotoM",
                            fontSize: FontSize.small),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: GapSize.xSmall,
                  ),
                  TextField(
                    controller: controller.instagramIdController,
                    decoration: InputDecoration(
                        filled: false,
                        hintStyle: const TextStyle(
                            fontSize: FontSize.large,
                            color: Colors.grey,
                            fontFamily: "NotoR"),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: GapSize.small,
                            horizontal: GapSize.small)),
                    style: const TextStyle(
                        fontSize: FontSize.large, fontFamily: "NotoR"),
                  ),
                  SizedBox(
                    height: HeightWithRatio.xxxxSmall,
                  ),
                  const Text(
                    '↕ 키',
                    style: TextStyle(
                        fontFamily: "NotoM", fontSize: FontSize.small),
                  ),
                  const SizedBox(
                    height: GapSize.xSmall,
                  ),
                  TextField(
                    controller: controller.lengthController,
                    decoration: InputDecoration(
                        filled: false,
                        hintStyle: const TextStyle(
                            fontSize: FontSize.large,
                            color: Colors.grey,
                            fontFamily: "NotoR"),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: GapSize.small,
                            horizontal: GapSize.small)),
                    style: const TextStyle(
                        fontSize: FontSize.large, fontFamily: "NotoR"),
                  ),
                  SizedBox(
                    height: HeightWithRatio.xxxxSmall,
                  ),
                  const Text(
                    '↔ 암 리치',
                    style: TextStyle(
                        fontFamily: "NotoM", fontSize: FontSize.medium),
                  ),
                  const SizedBox(
                    height: GapSize.xSmall,
                  ),
                  TextField(
                    controller: controller.reachController,
                    decoration: InputDecoration(
                        filled: false,
                        hintStyle: const TextStyle(
                            fontSize: FontSize.large,
                            color: Colors.grey,
                            fontFamily: "NotoR"),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: GapSize.small,
                            horizontal: GapSize.small)),
                    style: const TextStyle(
                        fontSize: FontSize.large, fontFamily: "NotoR"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
