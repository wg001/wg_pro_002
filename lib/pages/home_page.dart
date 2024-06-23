import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wg_pro_002/pages/home/home_page_logged_in.dart';
import 'package:wg_pro_002/pages/home/home_page_logged_out.dart';
import 'package:wg_pro_002/redux/wg_state.dart';
import 'package:wg_pro_002/utils/logger_util.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    //  Store<WGState> store = StoreProvider.of(context);
    Store<WGState> store = StoreProvider.of(context);
    bool? isLoggedIn = store.state.login ?? false;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        key: ValueKey('add todo'),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('wg'),
                  content: Text('This is a dialog message.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 关闭对话框
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              });
        },
      ),
      body: Container(
          color: Colors.orange,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: isLoggedIn
                  ? HomePageLoggedIn() // Assuming this is a custom widget for logged-in users
                  : HomePageLoggedOut(), // And this one for logged-out users
            ),
          )),
    );
  }

  void navigateToLogin(context) {
    //LogUtils
    LogUtils.logInfo("This is an informational message:。。。");
    // (emailController.text)
    NavigatorUtils.goLogin(context);
  }
}
