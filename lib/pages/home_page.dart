import 'dart:developer';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Home Page"),
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
              }
          );
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("Welcome to the Home Page!"),
            Stack(
              children: [
                const Padding(
                  //padding: EdgeInsets.all(8.0),
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 30.0, // 增加右侧填充，确保图标不覆盖文本
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  child: Text(
                    'Welcome to the Home Page!',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,

                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Details'),
                            content: Text('This is the detail information.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // 关闭对话框
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                log("details");
                 Map<String,String> args = {
                   'id':'32',
                   'phone':'12442',
                   'email':'aksdf@gmail.com',
                 };
                Router.of(context).routerDelegate.setNewRoutePath(RouteSettings(name: '/details',arguments: args));
              },
              child: Text('Go to Details Page'),
            ),
            ElevatedButton(
              onPressed: () {
                log("settings");
                Router.of(context).routerDelegate.setNewRoutePath(RouteSettings(name: '/settings'));
              },
              child: Text('Go to Settings Page'),
            ),
          ],
        ),
      ),
    );
  }
}
