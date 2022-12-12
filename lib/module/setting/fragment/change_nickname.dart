import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';

class ModifyMyInfo extends GetView<SettingController> {
  const ModifyMyInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '프로필 수정',
          ),
          actions: [
            TextButton(
                onPressed: () {
                  controller.changeUserInfo();
                },
                child: Text('저장'))
          ],
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
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(Column(
                              children: [
                                Container(
                                  height: Get.height * 0.05,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(RadiusSize.large)),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: WidthWithRatio.small,
                                    ),
                                    child: GridView.builder(
                                      itemCount:
                                          controller.app.levelImage.length,
                                      //item 개수
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              //1 개의 행에 보여줄 item 개수
                                              childAspectRatio: 1 / 1.1,
                                              //item 의 가로 1, 세로 1.3 의 비율
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: GapSize.xxSmall),
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.selectedUserLevel
                                                  .value = index;
                                              Get.back();
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      GapSize.xxxSmall,
                                                      GapSize.xxSmall,
                                                      GapSize.xxxSmall,
                                                      GapSize.xxSmall),
                                              decoration: noShadowBoxDecoration,
                                              child: Image.asset(controller
                                                  .app.levelImage[index]),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ));
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 115,
                              width: 120,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    fit: BoxFit.fill,
                                    controller.app.levelImage[
                                        controller.selectedUserLevel.value ??
                                            0],
                                  ),
                                  Align(
                                      alignment: Alignment(1.1, 1),
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[200],
                                        ),
                                        child: Container(
                                            padding:
                                                EdgeInsets.all(GapSize.xxSmall),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black),
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 15,
                                            )),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
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
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              filled: false,
                              hintText: controller
                                  .auth.user.value!.userNickname!.value,
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
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              filled: false,
                              hintText: controller
                                  .auth.user.value!.instaNickname!.value,
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
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              filled: false,
                              hintText:
                                  controller.auth.user.value!.userHeight!.value,
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
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                              filled: false,
                              hintText:
                                  controller.auth.user.value!.userReach!.value,
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
