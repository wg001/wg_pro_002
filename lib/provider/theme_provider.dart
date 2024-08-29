///  theme_provider.dart
///
///  Created by iotjin on 2022/07/10.
///  description: 主题管理

// ignore_for_file: unused_element

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wg_pro_002/config/colors.dart';

const String _appThemeKey = 'AppTheme';
const String _themeSystem = 'System';
const String _themeLight = 'Light';
const String _themeDark = 'Dark';
const String _themeBlue = 'Blue';
const String _themePurple = 'Purple';
const Color _lightThemeColor = WGColors.ThemeColor;
const Color _darkThemeColor = WGColors.ThemeDarkColor;
const Color _blueThemeColor = WGColors.ThemeBlueColor;
const Color _purpleThemeColor = WGColors.ThemePurpleColor;

enum ThemeMethod { themeSystem, themeLight, themeDark, themeBlue, themePurple }

/// 使用：_methodValues[ThemeMethod.themeSystem]
const _methodValues = {
  ThemeMethod.themeSystem: _themeSystem,
  ThemeMethod.themeLight: _themeLight,
  ThemeMethod.themeDark: _themeDark,
  ThemeMethod.themeBlue: _themeBlue,
  ThemeMethod.themePurple: _themePurple,
};

/// app的设置是否高于系统设置
/// 需要设置为true,并在 lib/project/configs/colors.dart 调用 provider.isDark()方法
const bool isPriorityApp = true;

class ThemeProvider extends ChangeNotifier {
  /// 是否跟随系统
  bool get isFollowSystem =>
      getThemeMode() == ThemeMode.system &&
      getThemeColor() != _blueThemeColor &&
      getThemeColor() != _purpleThemeColor;

  /// 获取主题列表
  List getThemeList() {
    return [
      {
        'label': '浅色',
        'value': _lightThemeColor,
        'themeMode': ThemeMethod.themeLight
      },
      {
        'label': '深色',
        'value': _darkThemeColor,
        'themeMode': ThemeMethod.themeDark
      },
      {
        'label': '蓝色',
        'value': _blueThemeColor,
        'themeMode': ThemeMethod.themeBlue
      },
      {
        'label': '紫色',
        'value': _purpleThemeColor,
        'themeMode': ThemeMethod.themePurple
      }
    ];
  }

  // /// 设置主题
  // void setTheme([ThemeMethod themeMode = ThemeMethod.themeLight]) {
  //   JhAESStorageUtils.saveString(_appThemeKey, _methodValues[themeMode]!);
  //   notifyListeners();
  // }

  /// 暗黑模式判断
  bool isDark(BuildContext context) {
    if (!isPriorityApp) {
      return Theme.of(context).brightness == Brightness.dark;
    } else {
      if (isFollowSystem) {
        return Theme.of(context).brightness == Brightness.dark;
      } else {
        return getThemeColor() == WGColors.ThemeDarkColor;
      }
    }
  }

  /// 获取当前主题模式
  ThemeMode getThemeMode() {
    final String theme = '';
    switch (theme) {
      case _themeLight:
        return ThemeMode.light;
      case _themeDark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// 获取当前主题色
  Color getThemeColor() {
    final String theme = '';
    switch (theme) {
      case _themeLight:
        return _lightThemeColor;
      case _themeDark:
        return _darkThemeColor;
      case _themeBlue:
        return _blueThemeColor;
      case _themePurple:
        return _purpleThemeColor;
      default:
        return _lightThemeColor;
    }
  }

  /// 获取主题配置
}
