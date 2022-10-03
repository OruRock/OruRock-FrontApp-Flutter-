import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/module/home/home.dart';
import 'package:oru_rock/module/home/home_controller.dart';
import 'package:oru_rock/module/marker_detail/marker_detail.dart';
import 'package:oru_rock/module/marker_detail/marker_detail_controller.dart';
import 'package:oru_rock/module/naver_map/nmap.dart';
import 'package:oru_rock/module/naver_map/nmap_controller.dart';
import 'package:oru_rock/module/search/search_controller.dart';
import 'package:oru_rock/module/search/search_page.dart';
import 'package:oru_rock/routes.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Get.putAsync(() => ApiFunction().init());
  FlutterNativeSplash.remove(); //로딩 끝나는 위치에 두어야 함(스플래시 제거)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        //텍스트 크기 고정
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!);
      },
      //첫 라우팅 페이지
      initialRoute: Routes.home,
      getPages: [
        //페이지 추가
        GetPage(
            name: Routes.home,
            page: () => const Home(),
            binding: BindingsBuilder(
              () => {Get.put(HomeController())},
            )),
        GetPage(
            name: Routes.nmap,
            page: () => const NMap(),
            binding: BindingsBuilder(
              () => {Get.put(NMapController())},
            )),
        GetPage(
            name: Routes.search,
            page: () => const Search(),
            binding: BindingsBuilder(
                  () => {Get.put(SearchController())},
            )),
        GetPage(
            name: Routes.marker,
            page: () => const MarkerDetail(store: null),
            transition: Transition.zoom,
            transitionDuration: const Duration(milliseconds: 250),
            binding: BindingsBuilder(
              () => {Get.put(MarkerDetailController())},
            )),
      ],
    );
  }
}
