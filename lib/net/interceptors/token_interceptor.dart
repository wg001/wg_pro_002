import 'package:dio/dio.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/local/local_storage.dart';

class TokenInterceptor extends InterceptorsWrapper {
  String? _token;

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
        // await initClient(_token);
      }
    }
    if (_token != null) {
      options.headers["Authorization"] = _token;
    }
    return super.onRequest(options, handler);
  }

  getAuthorization() async {
    String? token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token == null) {
    } else {
      _token = token;
      return token;
    }
  }
}
