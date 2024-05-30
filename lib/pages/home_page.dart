import 'dart:developer';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to the Home Page!"),
            ElevatedButton(
              onPressed: () {
                log("details");
                Router.of(context).routerDelegate.setNewRoutePath(RouteSettings(name: '/details',arguments: ));
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
