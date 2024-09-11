import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index, {bool refreshScreen = true}) {
    _currentIndex = index;
    if (refreshScreen) {
      notifyListeners(); // 通知监听器状态已更改
    }
  }
}
