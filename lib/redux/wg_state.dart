import 'package:wg_pro_002/app/model/User.dart';
import 'package:wg_pro_002/redux/login_redux.dart';
import 'package:wg_pro_002/redux/middleware/epic_middleware.dart';
import 'package:wg_pro_002/redux/user_redux.dart';
import 'package:redux/redux.dart';

class WGState {
  ///用户信息
  User? userInfo;

  ///是否登录
  bool? login;

  WGState({this.userInfo, this.login});
}

WGState appReducer(WGState state, action) {
  return WGState(
      userInfo: UserReducer(state.userInfo, action),
      login: LoginReducer(state.login, action));
}

final List<Middleware<WGState>> middleware = [
  EpicMiddleware<WGState>(loginEpic),
];
