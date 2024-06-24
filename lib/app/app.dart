import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';

import 'package:wg_pro_002/app/model/User.dart';
import 'package:wg_pro_002/pages/login_page.dart';
import 'package:wg_pro_002/pages/main_page.dart';
import 'package:wg_pro_002/pages/settings_page.dart';
import 'package:wg_pro_002/pages/welcome_page.dart';
import 'package:wg_pro_002/redux/wg_state.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';

class FlutterReduxApp extends StatefulWidget {
  const FlutterReduxApp({super.key});

  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp>
    with HttpErrorListener {
  final store = Store<WGState>(appReducer,

      ///拦截器
      middleware: middleware,

      ///初始化数据
      initialState: WGState(
          userInfo: User.empty(),
          login: false,
          homePageData: null,
          forceUpdate: true,
          lastFetchTime: null));
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreBuilder<WGState>(builder: (context, store) {
        Widget app = MaterialApp(
            navigatorKey: navKey,

            ///多语言实现代理

            ///命名式路由
            /// "/" 和 MaterialApp 的 home 参数一个效果
            ///⚠️ 这里的 name调用，里面 pageContainer 方法有一个 MediaQuery.of(context).copyWith(textScaleFactor: 1),
            ///⚠️ 而这里的 context 用的是 WidgetBuilder 的 context  ～
            ///⚠️ 所以 MediaQuery.of(context) 这个 InheritedWidget 就把这个 context “登记”到了 Element 的内部静态 _map 里。
            ///⚠️ 所以键盘弹出来的时候，触发了顶层的 MediaQueryData 发生变化，自然就触发了“登记”过的 context 的变化
            ///⚠️ 比如 LoginPage 、HomePage ····
            ///⚠️ 所以比如你在 搜索页面 键盘弹出时，下面的 HomePage.sName 对应的 WidgetBuilder 会被触发
            ///⚠️ 这个是我故意的，如果不需要，可以去掉 pageContainer 或者不要用这里的 context
            routes: {
              WelcomePage.sName: (context) {
                return const WelcomePage();
              },
              MainPage.sName: (context) {
                return const MainPage();
              },
              LoginPage.sName: (context) {
                return NavigatorUtils.pageContainer(const LoginPage(), context);
              },
              SettingsPage.sName: (context) {
                return NavigatorUtils.pageContainer(
                    const SettingsPage(), context);
              },
            });

        return app;
      }),
    );
  }
}

mixin HttpErrorListener on State<FlutterReduxApp> {
  // StreamSubscription? stream;
  StreamSubscription? stream;

  GlobalKey<NavigatorState> navKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    ///Stream演示event bus
    // stream = eventBus.on<HttpErrorEvent>().listen((event) {
    //   errorHandleFunction(event.code, event.message);
    // });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream!.cancel();
      stream = null;
    }
  }

  ///网络错误提醒
  errorHandleFunction(int? code, message) {
    var context = navKey.currentContext!;
    switch (code) {
      // case Code.NETWORK_ERROR:
      //   showToast(GSYLocalizations.i18n(context)!.network_error);
      //   break;
      // case 401:
      //   showToast(GSYLocalizations.i18n(context)!.network_error_401);
      //   break;
      // case 403:
      //   showToast(GSYLocalizations.i18n(context)!.network_error_403);
      //   break;
      // case 404:
      //   showToast(GSYLocalizations.i18n(context)!.network_error_404);
      //   break;
      // case 422:
      //   showToast(GSYLocalizations.i18n(context)!.network_error_422);
      //   break;
      // case Code.NETWORK_TIMEOUT:
      // //超时
      //   showToast(GSYLocalizations.i18n(context)!.network_error_timeout);
      //   break;
      // case Code.GITHUB_API_REFUSED:
      // //Github API 异常
      //   showToast(GSYLocalizations.i18n(context)!.github_refused);
      //   break;
      default:
        showToast("unknown $message");
        break;
    }
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG);
  }
}
