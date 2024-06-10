import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/net/result_data.dart';

class UserDao {
  static login(userName, password, store) async {
    String type = userName + ":" + password;
    ResultData? res;
    dynamic? resultDataa;
    print("===========");
    return DataResult(resultDataa, true);
  }
}
