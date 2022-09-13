import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:oru_rock/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:oru_rock/function/api_func.dart';
import 'package:oru_rock/module/analysis/analysis.dart';
import 'package:oru_rock/module/analysis/analysis_controller.dart';
import 'package:oru_rock/module/naver_map/nmap.dart';
import 'package:oru_rock/module/naver_map/nmap_controller.dart';
import 'package:oru_rock/routes.dart';
import 'package:oru_rock/module/login/login.dart';
import 'package:oru_rock/module/login/login_controller.dart';
import 'package:oru_rock/constant/config.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Get.putAsync(() => ApiFunction().init());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // firebase chrlghk
  KakaoSdk.init(nativeAppKey: '${KakaoLogin.kakao_native_key}');
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
            name: Routes.analysis,
            page: () => const Analysis(),
            binding: BindingsBuilder(
              () => {Get.put(AnalysisController())},
            )),
        GetPage(
            name: Routes.nmap,
            page: () => const NMap(),
            binding: BindingsBuilder(
              () => {Get.put(NMapController())},
            )),
      ],
    );
  }
}
