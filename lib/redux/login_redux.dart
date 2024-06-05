import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:wg_pro_002/redux/wg_state.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';

final LoginReducer = combineReducers<bool?>([
  TypedReducer<bool?, LoginSuccessAction>(_loginResult),
  TypedReducer<bool?, LogoutAction>(_logoutResult),
]);

bool? _loginResult(bool? result, LoginSuccessAction action) {
  if (action.success == true) {
    NavigatorUtils.goMainPage(action.context);
  }
  return action.success;
}

class LoginMiddleware implements MiddlewareClass<WGState> {
  @override
  void call(Store<WGState> store, dynamic action, NextDispatcher next) {
    if (action is LogoutAction) {
      // UserDao.clearAll(store);
      // WebViewCookieManager().clearCookies();
      // SqlManager.close();
      NavigatorUtils.goLogin(action.context);
    }
    // Make sure to forward actions to the next middleware in the chain!
    next(action);
  }
}

bool? _logoutResult(bool? result, LogoutAction action) {
  return true;
}

class LoginSuccessAction {
  final BuildContext context;
  final bool success;

  LoginSuccessAction(this.context, this.success);
}

class LogoutAction {
  final BuildContext context;

  LogoutAction(this.context);
}
