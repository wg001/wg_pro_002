import 'package:flutter/material.dart';
import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/dao/loan_dao.dart';
import 'package:wg_pro_002/app/model/Home.dart';

class HomePageProvider extends ChangeNotifier {
  HomeRet? homePageData;
  bool isLoading = false;

  void fetchHomePageData() async {
    isLoading = true;
    notifyListeners();
    try {
      DataResult ret = await LoanDao.getPageIndex();
      if (ret.result) {
        homePageData = ret.data as HomeRet;
      } else {
        throw Exception("get index page failed");
      }
      isLoading = false;
    } catch (e, stacktrace) {
      isLoading = false;
      print('An error occurred: $e'); // 打印异常信息
      print('Stacktrace: $stacktrace'); // 打印堆栈跟踪信息
    } finally {
      notifyListeners();
    }
  }

  void refreshData() {
    fetchHomePageData();
  }
}
