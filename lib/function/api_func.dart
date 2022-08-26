import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:oru_rock/model/geocoding_model.dart';

class ApiFunction extends GetxService {
  var dio = Dio();
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  Future<ApiFunction> init() async {
    //기본 url 인터셉터에 탑제

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (options.headers.isEmpty) {
        options.headers = headers;
        options.baseUrl = '';
      }
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
    return headers;
  }

  Map<String, String> get naverApiHeaders {
    Map<String, String> headers = {};
    headers['X-NCP-APIGW-API-KEY-ID'] = 'lhtdt0293p';
    headers['X-NCP-APIGW-API-KEY'] = 'UOSneSZrYXbBFwsCA5faKWpaWZFhPOS6ZJpK6KBq';
    return headers;
  }
}
