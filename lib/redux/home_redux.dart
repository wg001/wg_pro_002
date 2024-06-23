// import 'package:flutter/material.dart';
// import 'package:redux/redux.dart';
// import 'package:wg_pro_002/app/model/User.dart';
// import 'package:wg_pro_002/dao/loan_dao.dart';
// import 'package:wg_pro_002/redux/wg_state.dart';
// import 'package:wg_pro_002/utils/common_utils.dart';

// import 'middleware/epic_store.dart';

// final HomeReducer = combineReducers<User?>([
//   TypedReducer<User?, UpdateUserAction>(_updateLoaded),
// ]);

// Stream<dynamic> homeEpic(Stream<dynamic> actions, EpicStore<WGState> store) {
//   Stream<dynamic> loginIn(HomeAction action, EpicStore<WGState> store) async* {
//     CommonUtils.showLoadingDialog(action.context);
//     var nv = Navigator.of(action.context);
//     var res = await LoanDao.getPageIndex(store);
//     print("here is loginEpic");
//     nv.pop(action);
//     yield LoginSuccessAction(action.context, (res != null && res.result));
//   }

//   return actions
//       .whereType<LoginAction>()
//       .switchMap((action) => loginIn(action, store));
// }

// class HomeAction {
//   final BuildContext context;
//   final String? username;
//   final String? validCode;

//   HomeAction(this.context, this.username, this.validCode);
// }

// /// 如果有 UpdateUserAction 发起一个请求时
// /// 就会调用到 _updateLoaded
// /// _updateLoaded 这里接受一个新的userInfo，并返回
// User? _updateLoaded(User? user, action) {
//   user = action.userInfo;
//   return user;
// }
