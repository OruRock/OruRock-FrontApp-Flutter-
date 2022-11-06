import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:oru_rock/common_widget/banner_ad.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/app/app_controller.dart';
import 'package:oru_rock/module/home/fragment/home_service_top.dart';
import 'package:flutter/material.dart';

class Home extends GetView<AppController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
/*            ElevatedButton(onPressed: (){
              controller.signOut();
            }, child: Text('로그아웃')),*/
            SizedBox(
              height: HeightWithRatio.xSmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GapSize.medium),
              child: Row(
                children: [
                  const CircleAvatar(
                    minRadius: 20,
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  AutoSizeText(
                    '${controller.auth.user!.displayName}님,\n오늘도 즐거운 클라이밍 되세요!',
                    maxLines: 2,
                    minFontSize: FontSize.medium,
                    maxFontSize: FontSize.large,
                    style: const TextStyle(
                        fontFamily: "NotoM",
                        height: 1.7),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: HeightWithRatio.xxxSmall,
            ),
            Obx(
              () => Visibility(
                visible: controller.isPinned.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: GapSize.medium, vertical: GapSize.small),
                      child: Text(
                        '오늘 갈 암장',
                        style: TextStyle(
                            fontSize: FontSize.large, fontFamily: "NotoB"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GapSize.medium),
                      child: GestureDetector(
                        onTap: () {
                          controller
                              .goMapToSelectedStore(controller.pinnedStoreId!);
                        },
                        child: Container(
                          height: HeightWithRatio.small,
                          decoration: shadowBoxDecoration,
                          child: Padding(
                            padding: const EdgeInsets.only(left: GapSize.small),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'asset/image/icon/pin_icon.png',
                                  height: HeightWithRatio.xxxSmall,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      controller.pinnedStoreName.value,
                                      style: pinTextStyle,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    controller.removePin();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(GapSize.medium),
              child: HomeServiceTop(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GapSize.medium),
              child: SizedBox(
                height: HeightWithRatio.medium,
                width: Get.width,
                child: const Center(child: BannerAdWidget()),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: GapSize.medium, vertical: GapSize.small),
              child: Text(
                '즐겨찾는 암장',
                style: TextStyle(fontSize: FontSize.large, fontFamily: "NotoB"),
              ),
            ),
            Obx(
                () => Expanded(
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.clientStoreBookMark.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            controller.goMapToSelectedStoreAtBookMark(index);
                          },
                          child: ListTile(

                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: GapSize.xxSmall),
                                child: controller.clientStoreBookMark[index].imageUrl == null
                                    ? Image.asset(
                                      'asset/image/logo/splash_logo.png')
                                    : Image.network(
                                      controller.clientStoreBookMark[index].imageUrl!,
                                ),
                              ),
                            ),
                            title: Text(controller.clientStoreBookMark[index].storeName!),
                            subtitle: Text(controller.clientStoreBookMark[index].storePhone!),
                            trailing: SizedBox(
                              width: 50,
                              height: 50,
                              child: LikeButton(
                                circleColor: const CircleColor(
                                    start: Color(0xff00ddff),
                                    end: Color(0xff0099cc)),
                                bubblesColor: const BubblesColor(
                                  dotPrimaryColor: Color(0xff33b5e5),
                                  dotSecondaryColor: Color(0xff0099cc),
                                ),
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.favorite,
                                    color: isLiked
                                        ? Colors.pinkAccent
                                        : Colors.grey,
                                    size: 25,
                                  );
                                  },
                                isLiked:
                                controller.detailClientStoreBookMark.value,
                                onTap: (bool isLiked) async {
                                  controller.updateBookMark(controller.clientStoreBookMark[index]);
                                  return isLiked;
                                  },
                              ),
                            ),
                          ),
                        );
                        },
                    separatorBuilder: (BuildContext context, int index) => const Divider(indent: 10, endIndent: 10),
                  ),
                ),
              ),
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
