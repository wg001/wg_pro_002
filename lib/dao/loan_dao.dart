import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/local/local_storage.dart';
import 'package:wg_pro_002/net/address.dart';
import 'package:wg_pro_002/net/api.dart';
import 'package:wg_pro_002/net/result_data.dart';
import 'package:wg_pro_002/utils/logger_util.dart';

class LoanDao {
  static getLoanInfo() async {}

  static getPageIndex() async {
    dynamic? resultData;
    try {
      var res = await httpManager.netFetch(Address.getPageIndex());

      if (res != null && res.data != null) {
        Map<String, dynamic> resMap =
            res.data is Map ? res.data : json.decode(res.data.toString());

        // Log the returned data
        print(resMap["ret"]);

        // Process the returned data
        if (resMap["ret"] is Map && resMap['ret'].containsKey('token')) {
          await LocalStorage.save(Config.TOKEN_KEY, resMap['ret']['token']);
        }
        resultData = resMap["ret"];

        return DataResult(resultData, true);
      }
    } catch (e) {
      if (kDebugMode) {
        print("pageIndex error: $e");
      }
      return DataResult(e.toString(), false);
    }

    return DataResult(resultData, true);
  }
}
