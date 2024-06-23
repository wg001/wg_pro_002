import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:wg_pro_002/net/code.dart';
import 'package:wg_pro_002/net/interceptors/error_interceptor.dart';
import 'package:wg_pro_002/net/interceptors/header_interceptor.dart';
import 'package:wg_pro_002/net/interceptors/response_interceptor.dart';
import 'package:wg_pro_002/net/interceptors/token_interceptor.dart';
import 'package:wg_pro_002/net/interceptors/log_interceptor.dart';
import 'package:wg_pro_002/net/result_data.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  final Dio _dio = Dio(); // 使用默认配置
  final TokenInterceptor _tokenInterceptors = TokenInterceptor();

  HttpManager() {
    _dio.interceptors.add(HeaderInterceptor());
    _dio.interceptors.add(_tokenInterceptors);
    _dio.interceptors.add(WGLogInterceptor());
    _dio.interceptors.add(ErrorInterceptor());
    _dio.interceptors.add(ResponseInterceptor());
  }

  Future<ResultData?> netFetch(url,
      {params,
      Map<String, dynamic>? header,
      Options? option,
      noTip = false}) async {
    Map<String, dynamic> headers = HashMap();
    if (header != null) {
      if (!header.containsKey('Access-Control-Allow-Origin')) {}
      headers.addAll(header);
    } else {
      option = Options(method: "POST");
      option.headers = headers;
    }

    resultError(DioException e) {
      Response? errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = Response(
            statusCode: 666, requestOptions: RequestOptions(path: url));
      }

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorResponse!.statusCode = Code.NETWORK_TIMEOUT;
      }
      return ResultData(
          Code.errorHandleFunction(errorResponse!.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioException catch (e) {
      return resultError(e);
    }
    if (response.data is DioException) {
      return resultError(response.data);
    }
    return response.data;
  }
}

final HttpManager httpManager = HttpManager();
