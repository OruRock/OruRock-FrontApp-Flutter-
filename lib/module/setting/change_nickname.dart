import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';

class ChangeNickname extends GetView<SettingController> {
  const ChangeNickname({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            '닉네임 변경',
            style: TextStyle(
                fontFamily: "NotoB",
                fontSize: FontSize.xLarge,
                height: 1.7,
                color: Colors.black),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: WidthWithRatio.xSmall),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: HeightWithRatio.xLarge,
                      ),
                      const Text(
                        '변경할 닉네임을 입력해주세요.',
                        style: TextStyle(
                            fontSize: FontSize.xxLarge, fontFamily: "NotoB"),
                      ),
                      const SizedBox(
                        height: GapSize.medium,
                      ),
                      TextField(
                        controller: controller.nicknameController,
                        decoration: InputDecoration(
                            filled: false,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                await controller.changeNickname();
                              },
                              icon: const Icon(
                                Icons.save_alt,
                                color: Colors.black,
                              ),
                            ),
                            hintText: controller.auth.user!.displayName,
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
                        height: GapSize.small,
                      ),
                      Text(
                        '닉네임은 띄어쓰기 포함, 2자 이상 10자 이하여야합니다.',
                        style: TextStyle(
                            fontSize: FontSize.small,
                            fontFamily: "NotoM",
                            color: Colors.grey),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
