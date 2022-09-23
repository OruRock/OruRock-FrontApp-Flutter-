import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/function/auth_func.dart';

class ApiFunction extends GetxService {
  var dio = Dio();
  final userAuth = Get.find<AuthFunction>();
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  Future<ApiFunction> init() async {
    //기본 url 인터셉터에 탑제
    dio.options.baseUrl = "http://3.39.138.3:8080/api";

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      loggerNoStack.v(options.data);
      options.headers = headers; //request시에 header 탑재
      logger.i(options.headers);
      logger.i(options.uri);
      return handler.next(options);
    }, onResponse: (response, handler) {
      loggerNoStack.v(response.statusCode);
      loggerNoStack.v(response.data);

      return handler.next(response);
    }, onError: (DioError exception, handler) {
      logger.e(
          "statusCode : ${exception.response?.statusCode} \n statusMessage : ${exception.message}");

      return handler.next(exception);
    }));

    return this;
  }

  Map<String, String> get headers {
    Map<String, String> headers = {};
    headers['content-type'] = 'application/json; charset=utf-8';
    headers['accept'] = 'application/json; charset=utf-8';
    headers['Authorization'] = userAuth.jwt;
    return headers;
  }

}
