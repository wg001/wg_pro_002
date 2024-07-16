import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/dao/user_dao.dart';
import 'package:wg_pro_002/local/local_storage.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';

class UserAuthNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _token;
  
  Future<bool> checkLoginStatus() async {
    if (!_isLoggedIn) {
      String? token = await LocalStorage.get(Config.TOKEN_KEY);
      _isLoggedIn = token == null;
    }

    return _isLoggedIn;
  }

  String? get apiToken => _token;

  String? _phone;
  String? _validCode;
  bool _isButtonDisabled = false;
  int _countdown = 60;
  Timer? _timer;

  String? get phone => _phone;
  String? get validCode => _validCode;
  bool get isButtonDisabled => _isButtonDisabled;
  int get countdown => _countdown;

  String? _lastLoginError;
  String? get lastLoginError => _lastLoginError;

  void updatePhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void updateValidCode(String code) {
    _validCode = code;
    notifyListeners();
  }

  void startTimer() {
    _isButtonDisabled = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        _countdown--;
      } else {
        _timer?.cancel();
        _countdown = 60;
        _isButtonDisabled = false;
      }
      notifyListeners();
    });
  }

  Future<void> login(BuildContext context) async {
    // Here you can add your login logic
    if (_phone == null || _validCode == null) {
      Fluttertoast.showToast(
        msg: 'Please enter all fields',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    DataResult loginRet = UserDao.login(_phone!, _validCode);
    if (loginRet.result) {
      _isLoggedIn = true;
      var data = loginRet.data as Map;
      _token = data["token"];
    } else {
      _lastLoginError = "login failed, plz try again later";
      _isLoggedIn = false;
      _token = null;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("phone", _phone!);
    await prefs.setString("validcode", _validCode!);
    // Simulate login success
    Fluttertoast.showToast(
      msg: _isLoggedIn ? 'Login Successful' : _lastLoginError ?? 'login failed',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
    if (_isLoggedIn) {
      // ignore: use_build_context_synchronously
      NavigatorUtils.goMainPage(context);
    }
    // Example action after login
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void logout() {
    _isLoggedIn = false;
    _token = null;
    notifyListeners();
  }
}
