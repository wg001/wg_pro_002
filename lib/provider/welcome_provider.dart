import 'package:flutter/material.dart';

class WelcomePageModel with ChangeNotifier {
  String _text = "";
  double _fontSize = 76;

  String get text => _text;
  double get fontSize => _fontSize;

  void updateText(String newText, double newFontSize) {
    _text = newText;
    _fontSize = newFontSize;
    notifyListeners();
  }

  void initAnimations(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      updateText("Welcome", 60);
    });
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      updateText("WGApp", 60);
    });
    Future.delayed(const Duration(seconds: 3, milliseconds: 500), () {
      Navigator.of(context).pushReplacementNamed('/main');
    });
  }
}
