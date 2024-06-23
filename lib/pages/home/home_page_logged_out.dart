import 'package:flutter/material.dart';
import 'package:wg_pro_002/utils/logger_util.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';

class HomePageLoggedOut extends StatelessWidget {
  const HomePageLoggedOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      elevation: 0,
      child: ListView(children: <Widget>[
        Card(
            child: ListTile(
          leading: Icon(Icons.business, color: Colors.black),
          title: Text("Company Information"),
          subtitle: Text("Find out more about our company."),
          trailing: ElevatedButton(
            onPressed: () => navigateToLogin(context),
            child: Text('Login'),
          ),
        ))
      ]),
    );
  }

  void navigateToLogin(context) {
    //LogUtils
    LogUtils.logInfo("This is an informational message:。。。");
    // (emailController.text)
    NavigatorUtils.goLogin(context);
  }
}
