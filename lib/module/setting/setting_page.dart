import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';

class Setting extends GetView<SettingController> {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '검색',
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
        body: Padding(
          padding: const EdgeInsets.only(
              top: GapSize.medium, left: GapSize.small, right: GapSize.small),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: GapSize.xSmall,
              ),
              TextField(
                decoration: InputDecoration(
                    filled: false,
                    suffixIcon: IconButton(
                      onPressed: () {
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    hintText: "암장을 검색해 보세요!",
                    hintStyle: const TextStyle(
                        fontSize: FontSize.large,
                        color: Colors.grey,
                        fontFamily: "NotoR"),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: GapSize.small, horizontal: GapSize.small)),
                style: const TextStyle(
                    fontSize: FontSize.large, fontFamily: "NotoR"),
              ),
              SizedBox(
                height: HeightWithRatio.xSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
