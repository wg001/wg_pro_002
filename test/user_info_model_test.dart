import 'package:flutter_test/flutter_test.dart';
import 'package:wg_pro_002/app/model/Home.dart';  // 确保这个路径是正确的
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'dart:convert';

import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/dao/user_dao.dart';

void main() {
  test('UserLoanInfo parsing test', () async {
      DataResult res = await UserDao.getUserInfo();
    if (res.result && res.data is UserInfo) {
        UserInfo userInfo = res.data as UserInfo;
        print('>>>>>>');
        print(userInfo.birthday);
    }
  });
}
