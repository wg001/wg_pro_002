import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wg_pro_002/app/model/AddressSelect.dart';
import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/net/address.dart';
import 'package:wg_pro_002/net/api.dart';
import 'package:wg_pro_002/net/result_data.dart';

class AddressDao {
  static getAddressById({String? id}) async {
    Map reqParams = {};
    if (id != null) {
      reqParams['id'] = id;
    }
    try {
      var res = await httpManager.netFetch(Address.getRegionList(),
          params: jsonEncode(reqParams));
      if (res != null && res.data != null) {
        Map<String, dynamic> resMap =
            res.data is Map ? res.data : json.decode(res.data.toString());
        List<dynamic> placeList = resMap['ret'];
        List<AddressSelect> addressList = placeList
            .map((placeJson) => AddressSelect.fromJson(placeJson))
            .toList();
        return DataResult(addressList, true);
      } else {
        return DataResult(null, false);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("getAddressById error: $e");
      }
      return DataResult(e.toString(), false);
    }
  }
}
