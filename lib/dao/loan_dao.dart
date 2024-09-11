import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wg_pro_002/app/model/Home.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/local/local_storage.dart';
import 'package:wg_pro_002/net/address.dart';
import 'package:wg_pro_002/net/api.dart';

class LoanDao {
  static getLoanInfo() async {}

  static getPageIndex() async {
    try {
      var res = await httpManager.netFetch(Address.getPageIndex());

      if (res != null && res.data != null) {
        Map<String, dynamic> resMap =
            res.data is Map ? res.data : json.decode(res.data.toString());

        // Log the returned data
        print(resMap["ret"]);

        // Process the returned data
        if (resMap["ret"] is Map && resMap['ret'].containsKey('token')) {
          await LocalStorage.secureSave(
              Config.TOKEN_KEY, resMap['ret']['token']);
        }
        HomeRet homeRet = HomeRet.fromJson(resMap["ret"]);
        print('-------------');
        print(homeRet.productCharacteristics);
        return DataResult(homeRet, true);
      }
      return DataResult(null, false);
    } catch (e) {
      if (kDebugMode) {
        print("pageIndex error: $e");
      }
      return DataResult(e.toString(), false);
    }
  }
}
