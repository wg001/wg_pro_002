import 'package:flutter/material.dart';
import 'package:wg_pro_002/pages/login_page.dart';
import 'package:wg_pro_002/pages/main_page.dart';
import 'package:wg_pro_002/pages/settings_page.dart';
import 'package:wg_pro_002/pages/welcome_page.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';

class WgGoApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  WgGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        // home: NavigatorUtils.pageContainer(WelcomePage(), context),
        routes: {
          WelcomePage.sName: (context) {
            return const WelcomePage();
          },
          MainPage.sName: (context) {
            return const MainPage();
          },
          LoginPage.sName: (context) {
            return NavigatorUtils.pageContainer(LoginPage(), context);
          },
          SettingsPage.sName: (context) {
            return NavigatorUtils.pageContainer(const SettingsPage(), context);
          },
          // 其他页面配置...
        });
  }
}
