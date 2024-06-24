import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:wg_pro_002/app/model/Home.dart';
import 'package:wg_pro_002/app/model/User.dart';
import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/dao/loan_dao.dart';
import 'package:wg_pro_002/redux/wg_state.dart';
import 'package:wg_pro_002/utils/common_utils.dart';

import 'middleware/epic_store.dart';

final homePageDataReducer = combineReducers<HomeRet>([
  TypedReducer<HomeRet?, FetchHomePageDataAction>(_startFetchHomePageData),
  TypedReducer<HomeRet?, FetchHomePageDataSuccessAction>(_fetchHomePageDataSuccess),
  TypedReducer<HomeRet?, FetchHomePageDataFailureAction>(_fetchHomePageDataFailure),
]);

HomeRet? _startFetchHomePageData(HomeRet state, FetchHomePageDataAction action) {
  // 返回当前状态，因为 FetchHomePageDataAction 不会改变 homePageData
  return state;
}

HomeRet? _fetchHomePageDataSuccess(HomeRet state, FetchHomePageDataSuccessAction action) {
  return action.data;
}

HomeRet? _fetchHomePageDataFailure(HomeRet state, FetchHomePageDataFailureAction action) {
  // 返回当前状态，因为 FetchHomePageDataFailureAction 不会改变 homePageData
  return state;
}

final lastFetchTimeReducer = combineReducers<DateTime?>([
  TypedReducer<DateTime?, FetchHomePageDataSuccessAction>(_updateLastFetchTime),
]);

DateTime? _updateLastFetchTime(DateTime? state, FetchHomePageDataSuccessAction action) {
  return action.timestamp;
}

final forceUpdateReducer = combineReducers<bool>([
  TypedReducer<bool, FetchHomePageDataFailureAction>(_forceUpdate),
  TypedReducer<bool, FetchHomePageDataAction>(_resetForceUpdate),
  TypedReducer<bool, FetchHomePageDataSuccessAction>(_resetForceUpdate),
]);

bool _forceUpdate(bool state, FetchHomePageDataFailureAction action) {
  return true;
}

bool _resetForceUpdate(bool state, dynamic action) {
  return false;
}

WGState homePageReducer(WGState state, dynamic action) {
  if (action is FetchHomePageDataAction) {
    return WGState(
        userInfo: state.userInfo,
        login: state.login,
        forceUpdate: false,
        lastFetchTime: state.lastFetchTime,
        homePageData: state.homePageData);
  } else if (action is FetchHomePageDataSuccessAction) {
    return WGState(
      homePageData: action.data,
      lastFetchTime: action.timestamp,
      forceUpdate: false,
      userInfo: state.userInfo,
      login: state.login,
    );
  } else if (action is FetchHomePageDataFailureAction) {
    return WGState(
      homePageData: state.homePageData,
      lastFetchTime: state.lastFetchTime,
      forceUpdate: true,
      userInfo: state.userInfo,
      login: state.login,
    );
  }

  return state;
}
class FetchHomePageDataAction {}

class FetchHomePageDataSuccessAction {
  final dynamic data;
  final DateTime timestamp;

  FetchHomePageDataSuccessAction(this.data, this.timestamp);
}

class FetchHomePageDataFailureAction {
  final String error;

  FetchHomePageDataFailureAction(this.error);
}

class ForceFetchHomePageDataAction {}

void homePageMiddleware(Store<WGState> store, dynamic action, NextDispatcher next) async {
  if (action is FetchHomePageDataAction || action is ForceFetchHomePageDataAction) {
    final now = DateTime.now();
    final lastFetchTime = store.state.lastFetchTime;
    final threshold = Duration(minutes: 10); // 设置更新间隔

    // 检查是否需要更新数据
    if (store.state.forceUpdate || lastFetchTime == null || now.difference(lastFetchTime) > threshold) {
      try {
        DataResult dataResult = await LoanDao.getPageIndex();
       
        if (dataResult.result) {
          store.dispatch(FetchHomePageDataSuccessAction(dataResult.data, now));
        } else {
          store.dispatch(FetchHomePageDataFailureAction('Failed to fetch data'));
        }
      } catch (e) {
        store.dispatch(FetchHomePageDataFailureAction(e.toString()));
      }
    }
  }

  next(action);
}

