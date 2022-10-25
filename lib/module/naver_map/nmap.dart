import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/constant/style/style.dart';
import 'package:oru_rock/module/naver_map/nmap_controller.dart';
import 'package:oru_rock/routes.dart';

class NMap extends GetView<NMapController> {
  const NMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(() => Stack(
              children: [
                NaverMap(
                  onMapCreated: controller.map.onMapCreated,
                  mapType: controller.map.mapType,
                  initLocationTrackingMode: controller.map.trackingMode,
                  locationButtonEnable: true,
                  indoorEnable: true,
                  onMapTap: controller.map.onMapTap,
                  maxZoom: 20,
                  minZoom: 5,
                  logoClickEnabled: false,
                  markers: controller.home.markers.value,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: _buildSearchButton(),
                ),
              ],
            )),
      ),
    );
  }

  _buildSearchButton() {
    return Container(
      width: Get.width / 1.2,
      height: HeightWithRatio.small,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(RadiusSize.large)),
      margin: const EdgeInsets.all(GapSize.medium),
      child: Material(
        borderRadius: BorderRadius.circular(RadiusSize.large),
        child: Ink(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(RadiusSize.large)),
          child: InkWell(
            borderRadius: BorderRadius.circular(RadiusSize.large),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.search);
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: GapSize.small, vertical: GapSize.small),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: GapSize.small),
                      child: Icon(
                        Icons.search_rounded,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.only(bottom: GapSize.xxxSmall),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        )),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '어느 암장을 찾으시나요?',
                        style: TextStyle(
                            color: Colors.grey, fontSize: FontSize.large),
                      ),
                    )),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerListView() {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: GapSize.xxLarge),
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue,
            ),
            SizedBox(
              height: GapSize.medium,
            ),
            ListTile(
              title: Text(
                "취향 검사 다시하기",
                style: drawerListTextStyle,
              ),
              leading: Icon(Icons.replay_rounded),
            ),
            Divider(),
            ListTile(
              title: Text(
                "Setting",
                style: drawerListTextStyle,
              ),
              leading: Icon(Icons.settings_rounded),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
