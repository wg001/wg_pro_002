import 'package:dio/dio.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, handler) {
    ///超时
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 30);
    return super.onRequest(options, handler);
  }
}
