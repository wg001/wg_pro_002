import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/local/local_storage.dart';
import 'package:wg_pro_002/pages/login_page.dart';

class TokenInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await getAuthorization(); // Always get the latest token
    if (token != null) {
      options.headers["token"] = token;
    }
    return super.onRequest(options, handler);
  }

  getAuthorization() async {
    String? token = await LocalStorage.secureGet(Config.TOKEN_KEY);
    return token;
  }
}
