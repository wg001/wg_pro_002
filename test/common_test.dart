import 'package:flutter_test/flutter_test.dart';
import 'package:wg_pro_002/dao/address_dao.dart';
import 'dart:convert';

import 'package:wg_pro_002/net/address.dart';

void main() {
  var homeData = AddressDao.getAddressById();
  print('Parsed data successfully:');
  print(homeData);
}
