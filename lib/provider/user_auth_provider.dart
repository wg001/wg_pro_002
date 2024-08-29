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
      String? token = await LocalStorage.secureGet(Config.TOKEN_KEY);
      _isLoggedIn = token != null;
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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
    // Validate input fields
    if (_phone == null ||
        _validCode == null ||
        _phone!.isEmpty ||
        _validCode!.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter all fields',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    // Perform the login operation
    try {
      DataResult loginRet = await UserDao.login(
          _phone!, _validCode!); // Assuming UserDao.login is asynchronous
      if (loginRet.result) {
        _isLoggedIn = true;
        var data = loginRet.data as Map<String, dynamic>;
        _token = data["token"];
        // Save login state and credentials
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("phone", _phone!);
        await prefs.setString("validcode", _validCode!);
        Fluttertoast.showToast(
          msg: 'Login Successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        NavigatorUtils.goMainPage(context);
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      _isLoggedIn = false;
      _token = null;
      Fluttertoast.showToast(
        msg: 'Login failed: ${e.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  Future<void> getAuthorization() async {
    _token = await LocalStorage.secureGet(Config.TOKEN_KEY);
    notifyListeners();
  }

  Future<void> clearToken() async {
    await LocalStorage.secureRemove(Config.TOKEN_KEY);
    _token = null;
    notifyListeners();
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
