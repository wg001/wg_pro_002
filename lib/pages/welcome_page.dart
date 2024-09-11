import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/pages/guest/login_or_register.dart';
import 'package:wg_pro_002/provider/app_data_provider.dart';
import 'package:wg_pro_002/provider/user_auth_provider.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';

/// 欢迎页

class WelcomePage extends StatefulWidget {
  static const String sName = "/";

  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appDataProvider =
          Provider.of<AppDataProvider>(context, listen: false);
      appDataProvider.initAdjust();
      appDataProvider.fetchAdjustAdid();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;

    ///防止多次进入
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   setState(() {
    //     text = "Welcome";
    //     fontSize = 60;
    //   });
    // });
    // Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
    //   setState(() {
    //     text = "WGApp";
    //     fontSize = 60;
    //   });
    // });
    Future.delayed(const Duration(seconds: 5), () {
      // UserDao.initUserInfo(store).then((res) {
      //   if (res != null && res.result) {
      //     NavigatorUtils.goHome(context);
      //   } else {
      //     NavigatorUtils.goLogin(context);
      //   }
      //   return true;
      // });
      NavigatorUtils.goMainPage(context);
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => const LoginOrRegister()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: SizedBox(
        width: double.infinity, // 指定宽度为无限，填充整个屏幕宽度
        height: double.infinity, // 指定高度为无限，填充整个屏幕高度
        child: Image(
          image: AssetImage('static/images/welcome.png'),
          fit: BoxFit.cover, // 图片将会覆盖整个屏幕，可能部分图片会被裁剪
        ),
      ),
    );
  }
}
