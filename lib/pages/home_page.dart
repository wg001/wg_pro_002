import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:wg_pro_002/utils/logger_util.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: screenHeight * 0.1,
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.bug_report, color: Colors.black),
                    title: Text("Report an Issue"),
                    subtitle: Text("Having an issue? Report it here"),
                    trailing: ElevatedButton(
                      onPressed: ()=>navigateToLogin(context),
                      child: Text('Login'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.4,
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.bug_report, color: Colors.black),
                    title: Text("Report an Issue"),
                    subtitle: Text("Having an issue? Report it here"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToLogin(context) {
    //LogUtils
    LogUtils.logInfo("This is an informational message:。。。");
    // (emailController.text)
    NavigatorUtils.goLogin(context);
  }
}
