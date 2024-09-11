import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/local/local_storage.dart';
import 'package:wg_pro_002/net/address.dart';
import 'package:wg_pro_002/net/api.dart';

class UserDao {
  static login(String phone, validCode) async {
    print('$phone,$validCode');
    Map params = {"phone": phone, "valid_code": validCode};
    try {
      var res = await httpManager.netFetch(Address.getLogin(),
          params: json.encode(params));

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

        return DataResult(resMap["ret"], true);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Login error: $e");
      }
      return DataResult(e.toString(), false);
    }

    return DataResult(null, false);
  }

  static getUserInfo() async {
    dynamic resultData;
    try {
      var res = await httpManager.netFetch(Address.getUserInfo(),
          params: json.encode({"part_info": 99}));

      if (res != null && res.data != null) {
        Map<String, dynamic> resMap =
            res.data is Map ? res.data : json.decode(res.data.toString());

        // Log the returned data

        resultData = resMap["ret"];
        UserInfo userInfo = UserInfo.fromJson(resMap["ret"]);
        return DataResult(userInfo, true);
      }
    } catch (e) {
      if (kDebugMode) {
        print("pageIndex error: $e");
      }
      return DataResult(e.toString(), false);
    }

    return DataResult(resultData, true);
  }

  static uploadImage(String pictureType, dynamic picture) async {
    Map params = {"picture_type": pictureType, 'picture': picture};
    try {
      var res = await httpManager.netFetch(Address.uploadImage(),
          params: json.encode(params));
      bool retSuccess = false;
      if (res != null && res.data != null) {
        Map<String, dynamic> resMap =
            res.data is Map ? res.data : json.decode(res.data.toString());

        // Log the returned data

        retSuccess = resMap.containsKey('success');
      }
      return DataResult(null, retSuccess);
    } catch (e) {
      if (kDebugMode) {
        print("pageIndex error: $e");
      }
      return DataResult(e.toString(), false);
    }
  }
}
