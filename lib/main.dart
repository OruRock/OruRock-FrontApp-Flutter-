import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:oru_rock/constant/config.dart';
import 'package:oru_rock/constant/style/theme.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/function/auth_func.dart';
import 'package:oru_rock/function/map_func.dart';
import 'package:oru_rock/helper/firebase_options.dart';
import 'package:oru_rock/module/app/app.dart';
import 'package:oru_rock/module/app/app_controller.dart';
import 'package:oru_rock/module/login/login.dart';
import 'package:oru_rock/module/login/login_controller.dart';
import 'package:oru_rock/module/setting/setting_controller.dart';
import 'package:oru_rock/module/store_detail_info/store_info_controller.dart';
import 'package:oru_rock/module/store_detail_info/store_info_page.dart';
import 'package:oru_rock/routes.dart';

void main() async {
  await GetStorage.init();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Get.putAsync(() => AuthFunction().init());
  await Get.putAsync(() => ApiFunction().init());
  await Get.putAsync(() => MapFunction().init());
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // firebase chrlghk
  KakaoSdk.init(nativeAppKey: Config.kakao_native_key);
  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: ['C7570CF719C5585A62E09942D0982A1A']));
  FlutterNativeSplash.remove(); //로딩 끝나는 위치에 두어야 함(스플래시 제거)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: mainTheme,
      builder: (context, child) {
        //텍스트 크기 고정
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!);
      },
      //첫 라우팅 페이지
      initialRoute: Routes.login,
      getPages: [
        //페이지 추가
        GetPage(
            name: Routes.login,
            page: () => const Login(),
            binding: BindingsBuilder(
              () => {Get.put(LoginController())},
            )),
        GetPage(
            name: Routes.app,
            page: () => App(),
            binding: BindingsBuilder(
              () => {
                Get.put(AppController()),
                Get.put(SettingController()),
              },
            )),
        GetPage(
            name: Routes.storeInfo,
            page: () => StoreInfo(),
            binding: BindingsBuilder(
              () => {Get.put(StoreInfoController())},
            )),
      ],
    );
  }
}
