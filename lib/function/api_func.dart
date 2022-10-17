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
    dio.options.baseUrl = "http://www.orurock.shop/api";

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
    headers['Authorization'] =
        "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ7XCJ1aWRcIjpcIlRkQWFreG9EWjlTMGF3WnFGdHROMmt0eFFZbTFcIixcInVzZXJfZW1haWxcIjpcIndodGp0amRkbjUyMEBnbWFpbC5jb21cIixcInVzZXJfaWRcIjoxOCxcInVzZV95blwiOjEsXCJ1c2VyX25pY2tuYW1lXCI6XCLsobDshLHsmrBcIixcImNyZWF0ZV9kYXRlXCI6XCIyMDIyLTA5LTIzIDE2OjU3OjExXCIsXCJ1cGRhdGVfZGF0ZVwiOlwiMjAyMi0xMC0xNyAxMTowMzozMlwifSIsImlhdCI6MTY2NTk3MjIxMywiZXhwIjoxNjk3NTA4MjEzfQ.wjjlyfGnLP-YIQ-yzL3Zinr8RZwadFyBQ9pxsTaEqOk";
    return headers;
  }
}
