import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

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
    headers['Authorization'] = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ7XCJ1c2VyX2VtYWlsXCI6XCJlbWFpbEBnbWFpbC5jb21cIixcInVzZXJfaWRcIjo1LFwidXNlX3luXCI6MSxcInVzZXJfbmlja25hbWVcIjpcIm5pY2tOYW1lXCIsXCJjcmVhdGVfZGF0ZVwiOlwiMjAyMi0wOS0yMiAxMTowNDoxNVwiLFwidXBkYXRlX2RhdGVcIjpcIjIwMjItMDktMjIgMTY6NTY6NTFcIixcInNpZFwiOlwic2lkXCJ9IiwiaWF0IjoxNjYzODMzNDExLCJleHAiOjE2OTUzNjk0MTF9.TMdHHkK6XpcgnIEL8WwC4re_S8AqKvS_WR5-TA_oLD0";
    return headers;
  }
}
