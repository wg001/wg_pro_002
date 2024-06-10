import 'package:flutter/material.dart';
import 'package:wg_pro_002/common/response_conf.dart';

class SettingsPage extends StatefulWidget {
  static const String sName = "setting";
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings Page")),
      body: Center(
        child: Text("Welcome to the Settings Page!"),
      ),
    );
  }

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingsPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    MathUtils.init(context);
    return Scaffold(
      appBar: AppBar(title: Text("Settings Page")),
      body: Center(
        child: Text("Welcome to the Settings Page!"),
      ),
    );
  }
}
