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
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = <Widget>[
      const Home(),
      const Search(),
      const NMap(),
      const Setting(),
    ];
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedTabIndex.value == Tabs.home) {
          if (controller.isOnCloseApp == false) {
            Fluttertoast.showToast(msg: "한 번 더 누르면 종료됩니다.");
            controller.onCloseApp();
            return false;
          } else {
            return true;
          }
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
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.grey,
                      size: 30,
                    ),
                    activeIcon: Icon(
                      Icons.home,
                      color: Colors.black,
                      size: 30,
                    ),
                    label: '홈',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                    activeIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 30,
                    ),
                    label: '검색',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.map,
                      color: Colors.grey,
                      size: 30,
                    ),
                    activeIcon: Icon(
                      Icons.map,
                      color: Colors.black,
                      size: 30,
                    ),
                    label: '지도',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.grey,
                      size: 30,
                    ),
                    activeIcon: Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: 30,
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
