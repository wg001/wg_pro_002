import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wg_pro_002/pages/login_page.dart';
import 'package:wg_pro_002/pages/main_page.dart';
import 'package:wg_pro_002/widget/never_overscroll_indicator.dart';

/// 导航栏
/// Created by guoshuyu
/// Date: 2018-07-16
class NavigatorUtils {
  ///替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
//    if (navigator == null) {
//      try {
//        navigator = Navigator.of(context);
//      } catch (e) {
//        error = true;
//      }
//    }
//
//    if (replace) {
//      ///如果可以返回，清空开始，然后塞入
//      if (!error && navigator.canPop()) {
//        navigator.pushAndRemoveUntil(
//          router,
//          ModalRoute.withName('/'),
//        );
//      } else {
//        ///如果不可返回，直接替换当前
//        navigator.pushReplacement(router);
//      }
//    } else {
//      navigator.push(router);
//    }
  }

  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  ///主页
  static goMainPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, MainPage.sName);
  }

  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }

  ///公共打开方式
  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => pageContainer(widget, context)));
  }

  ///Page页面的容器，做一次通用自定义
  static Widget pageContainer(widget, BuildContext context) {
    return MediaQuery(

        ///不受系统字体缩放影响
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: NeverOverScrollIndicator(
          needOverload: false,
          child: widget,
        ));
  }

  ///弹出 dialog
  static Future<T?> showWGDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder? builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(

              ///不受系统字体缩放影响
              data: MediaQueryData.fromView(
                      WidgetsBinding.instance.platformDispatcher.views.first)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: NeverOverScrollIndicator(
                needOverload: false,
                child: SafeArea(child: builder!(context)),
              ));
        });
  }
}
