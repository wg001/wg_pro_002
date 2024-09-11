import 'package:flutter/material.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/pages/login_page.dart';
import 'package:wg_pro_002/pages/main_page.dart';
import 'package:wg_pro_002/pages/settings_page.dart';
import 'package:wg_pro_002/pages/welcome_page.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';

class WgGoApp extends StatelessWidget {
  const WgGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    MathUtils.init(context);
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // 定义明亮主题的色彩方案
          colorScheme: const ColorScheme.light(
            primary: WGColors.ThemeColor, // 主色
            // secondary: Colors.amber,
          ),
          appBarTheme: const AppBarTheme(
            color: WGColors.ThemeColor, // 确保这里设置了您想要的颜色
          ),
        ),
        navigatorKey: Config.navigatorKey,
        // home: NavigatorUtils.pageContainer(WelcomePage(), context),
        routes: {
          WelcomePage.sName: (context) {
            return const WelcomePage();
          },
          MainPage.sName: (context) {
            return MainPage();
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
