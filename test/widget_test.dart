// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wg_pro_002/main.dart';
import 'dart:async';

Future<void> main() async {
  print('Start');

  // 启动一个定时器，模拟一个异步操作
  Timer(Duration(seconds: 3), () {
    print('Timer 1 done');
  });

  // 启动另一个定时器，模拟另一个异步操作
  Timer(Duration(seconds: 2), () {
    print('Timer 2 done');
  });

  // 等待 2 秒，但不会阻塞主线程
  await Future.delayed(Duration(seconds: 5), () {
    print('Future delayed done');
  });

  print('End');
}
