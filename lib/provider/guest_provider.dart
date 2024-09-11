import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:wg_pro_002/config/strings.dart';

class GuestProvider extends ChangeNotifier {
  bool _readPrivacyAgreement = false;
  bool get isReadPrivacyAgreement => _readPrivacyAgreement;

  String _guestPhone = '';
  String get guestPhone => _guestPhone;

  String? _password;
  String? get password => _password;

  String _doubleCheckSettingPasswordErrMsg = "";
  String get doubleCheckSettingPasswordErrMsg =>
      _doubleCheckSettingPasswordErrMsg;

  void setPrivacyAgreement() {
    _readPrivacyAgreement = !_readPrivacyAgreement;
    notifyListeners();
  }

  void setGuestPhone(String phone) {
    _guestPhone = phone;
    notifyListeners();
  }

  void setErrMsg(String errMsg, {bool refreshPage = true}) {
    _doubleCheckSettingPasswordErrMsg = errMsg;
    if (refreshPage) {
      notifyListeners();
    }
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  bool checkSettingPassword(String password, String confirmPassword) {
    _doubleCheckSettingPasswordErrMsg = "";
    if (password.isEmpty) {
      _doubleCheckSettingPasswordErrMsg = "密码无效";
    } else if (password != confirmPassword) {
      _doubleCheckSettingPasswordErrMsg = Strings.PasswordDoubleCheckFailed;
    }
    setErrMsg(_doubleCheckSettingPasswordErrMsg);
    return _doubleCheckSettingPasswordErrMsg.isNotEmpty;
  }
}
