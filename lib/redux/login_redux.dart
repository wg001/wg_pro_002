import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import 'package:wg_pro_002/dao/user_dao.dart';
import 'package:wg_pro_002/redux/middleware/epic_store.dart';
import 'package:wg_pro_002/redux/wg_state.dart';
import 'package:wg_pro_002/utils/common_utils.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';
import 'package:rxdart/rxdart.dart';

final LoginReducer = combineReducers<bool?>([
  TypedReducer<bool?, LoginSuccessAction>(_loginResult),
  TypedReducer<bool?, LogoutAction>(_logoutResult),
]);

bool? _loginResult(bool? result, LoginSuccessAction action) {
  if (action.success == true) {
    print("login successfully");
    NavigatorUtils.goMainPage(action.context);
  }
  return action.success;
}

// class LoginMiddleware implements MiddlewareClass<WGState> {
//   @override
//   void call(Store<WGState> store, dynamic action, NextDispatcher next) {
//     if (action is LogoutAction) {
//       // UserDao.clearAll(store);
//       // WebViewCookieManager().clearCookies();
//       // SqlManager.close();
//       NavigatorUtils.goLogin(action.context);
//     }
//     // Make sure to forward actions to the next middleware in the chain!
//     next(action);
//   }
// }

Stream<dynamic> loginEpic(Stream<dynamic> actions, EpicStore<WGState> store) {
  Stream<dynamic> loginIn(LoginAction action, EpicStore<WGState> store) async* {
    CommonUtils.showLoadingDialog(action.context);
    var nv = Navigator.of(action.context);
    var res = await UserDao.login(
        action.username!.trim(), action.validCode!.trim(), store);
    print("here is loginEpic");
    nv.pop(action);
    yield LoginSuccessAction(action.context, (res != null && res.result));
  }

  return actions
      .whereType<LoginAction>()
      .switchMap((action) => loginIn(action, store));
}

class LoginAction {
  final BuildContext context;
  final String? username;
  final String? validCode;

  LoginAction(this.context, this.username, this.validCode);
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
