import 'package:redux/redux.dart';
import 'package:wg_pro_002/app/model/User.dart';

final UserReducer = combineReducers<User?>([
  TypedReducer<User?, UpdateUserAction>(_updateLoaded),
]);

///定一个 UpdateUserAction ，用于发起 userInfo 的的改变
///类名随你喜欢定义，只要通过上面TypedReducer绑定就好
class UpdateUserAction {
  final User? userInfo;

  UpdateUserAction(this.userInfo);
}

/// 如果有 UpdateUserAction 发起一个请求时
/// 就会调用到 _updateLoaded
/// _updateLoaded 这里接受一个新的userInfo，并返回
User? _updateLoaded(User? user, action) {
  user = action.userInfo;
  return user;
}
