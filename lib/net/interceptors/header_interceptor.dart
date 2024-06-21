import 'package:dio/dio.dart';
import 'package:wg_pro_002/config/config.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, handler) {
    ///超时
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 30);

    var config = Config();
    options.headers[Config.APP_NAME_KEY] = config.appName;
    options.headers[Config.API_VERSION_KEY] = config.apiVersion;
    options.headers[Config.APP_VERSION_KEY] = config.clientVersion;

    return super.onRequest(options, handler);
  }
}
