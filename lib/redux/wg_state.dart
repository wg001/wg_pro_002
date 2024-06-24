import 'package:wg_pro_002/app/model/Home.dart';
import 'package:wg_pro_002/app/model/User.dart';
import 'package:wg_pro_002/pages/home_page.dart';
import 'package:wg_pro_002/redux/home_redux.dart';
import 'package:wg_pro_002/redux/login_redux.dart';
import 'package:wg_pro_002/redux/middleware/epic_middleware.dart';
import 'package:wg_pro_002/redux/user_redux.dart';
import 'package:redux/redux.dart';

class WGState {
  ///用户信息
  User? userInfo;

  HomeRet? homePageData;

  final DateTime? lastFetchTime;
  final bool forceUpdate; // 新增字段

  ///是否登录
  bool? login;

  WGState(
      {required this.userInfo,
      required this.login,
      this.homePageData,
      required this.lastFetchTime,
      required this.forceUpdate});
}

WGState appReducer(WGState state, action) {
  return WGState(
      userInfo: UserReducer(state.userInfo, action),
      login: LoginReducer(
        state.login,
        action,
      ),
      forceUpdate: false,
      lastFetchTime: null,
      homePageData: homePageDataReducer(state.homePageData, action));
}

final List<Middleware<WGState>> middleware = [
  homePageMiddleware,
  EpicMiddleware<WGState>(loginEpic),
];
