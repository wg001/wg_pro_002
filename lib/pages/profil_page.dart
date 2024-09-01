import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/local/local_storage.dart';
import 'package:wg_pro_002/net/interceptors/token_interceptor.dart';
import 'package:wg_pro_002/pages/login_page.dart';
import 'package:wg_pro_002/utils/common_utils.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Settings Page")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Welcome to the Profil Page!"),
            logOut(context)
          ],
          //   chi
          //   context
          //  Text("Welcome to the Profil Page!"), LogOut(context)),
        )));
  }

  Widget logOut(BuildContext context) {
    return SizedBox(
      width: MathUtils.screenWidth * 0.3,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange, // 设置按钮的背景颜色
          foregroundColor: Colors.white, // 设置按钮文字颜色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // 设置圆角
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 2, vertical: 2), // 设置按钮内部的填充
          elevation: 10, // 设置阴影
        ),
        onPressed: () => logout(context),
        child: const Text("Login out"), // Button text
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    // 获取 Interceptor 实例，假设通过依赖注入或全局访问
    await LocalStorage.secureRemove(
        Config.TOKEN_KEY); // Clear token from storage

    CommonUtils.showToast("operator successfully");

    // 可选: 重置应用状态或导航到登陆页
    // ignore: use_build_context_synchronously
    Config.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        LoginPage.sName, (Route<dynamic> route) => false);
  }
}
