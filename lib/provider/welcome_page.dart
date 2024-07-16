import 'package:flutter/material.dart';

class WelcomeProvider with ChangeNotifier {
  String _text = "";
  double _fontSize = 76;
  VoidCallback? onNavigate;

  String get text => _text;
  double get fontSize => _fontSize;

  WelcomeProvider({this.onNavigate}) {
    _initAnimations();
  }

  void _initAnimations() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _text = "Welcome";
      _fontSize = 60;
      notifyListeners();
    });
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      _text = "WGApp";
      _fontSize = 60;
      notifyListeners();
    });
    Future.delayed(const Duration(seconds: 3, milliseconds: 500), () {
      if (onNavigate != null) {
        onNavigate!();
      }
    });
  }
}
