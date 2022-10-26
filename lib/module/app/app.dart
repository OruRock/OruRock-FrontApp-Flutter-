import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:oru_rock/constant/style/size.dart';
import 'package:oru_rock/module/app/app_controller.dart';
import 'package:oru_rock/module/home/home.dart';
import 'package:oru_rock/module/naver_map/nmap.dart';
import 'package:oru_rock/module/search/search_page.dart';
import 'package:oru_rock/module/setting/setting_page.dart';

class App extends GetView<AppController> {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = <Widget>[
      Home(),
      Search(),
      NMap(),
      Setting(),
    ];
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedTabIndex.value == Tabs.home) {
          if (controller.isOnCloseApp == false) {
            Fluttertoast.showToast(msg: "한 번 더 누르면 종료됩니다.");
            controller.onCloseApp();
          }
          return false;
        } else {
          controller.selectedTabIndex.value = Tabs.home;
          return false;
        }
      },
      child: Obx(() => SafeArea(
        child: Scaffold(
              body: IndexedStack(
                key: ValueKey(controller.selectedTabIndex.value),
                index: controller.selectedTabIndex.value.index,
                children: screens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  controller.selectedTabIndex.value = Tabs.getTabByIndex(index);
                },
                currentIndex: controller.selectedTabIndex.value.index,
                type: BottomNavigationBarType.fixed,
                unselectedLabelStyle: const TextStyle(
                    fontFamily: "NotoR",
                    color: Colors.black,
                    fontSize: FontSize.xSmall),
                selectedLabelStyle: const TextStyle(
                    fontFamily: "NotoB",
                    color: Colors.red,
                    fontSize: FontSize.xSmall),
                selectedItemColor: Colors.black,
                items: const [
                  BottomNavigationBarItem(
                    // icon: Icon(Icons.home),
                    icon: Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Icon(
                        Icons.home_outlined,
                        color: Colors.black,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                    ),
                    label: '홈',
                  ),
                  BottomNavigationBarItem(
                    // icon: Icon(Icons.home),
                    icon: Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Icon(
                        Icons.search_outlined,
                        color: Colors.black,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    label: '검색',
                  ),
                  BottomNavigationBarItem(
                    // icon: Icon(Icons.home),
                    icon: Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Icon(
                        Icons.map_outlined,
                        color: Colors.black,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Icon(
                        Icons.map,
                        color: Colors.black,
                      ),
                    ),
                    label: '지도',
                  ),
                  BottomNavigationBarItem(
                    // icon: Icon(Icons.home),
                    icon: Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Icon(
                        Icons.settings_outlined,
                        color: Colors.black,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                    ),
                    label: '설정',
                  ),
                ],
              ),
            ),
      )),
    );
  }
}
