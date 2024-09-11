///  colors.dart
///
///  Created by iotjin on 2020/07/06.
///  description:  颜色 配置
library;

// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/provider/theme_provider.dart';

/// 暗黑模式判断
extension ThemeExtension on BuildContext {
  // bool get jhIsDark => Theme.of(this).brightness == Brightness.dark;

  bool get jhIsDark => Provider.of<ThemeProvider>(this).isDark(this);
}

class WGColors {
  /// 设置动态颜色
  static Color dynamicColor(BuildContext context, Color lightColor,
      [Color? darkColor]) {
    var isDark = context.jhIsDark;
    return isDark ? darkColor ?? lightColor : lightColor;
  }

  // 主题色（导航条背景、提交按钮背景、弹框确认文字、表单图标录入光标）
  // 暗黑模式高亮显示颜色按kThemeColor设置，如tabBar选中文字图标、提交按钮背景色、指示器选中下划线、光标等
  static const Color ThemeColor = Color.fromRGBO(200, 29, 40, 1);
  static const Color ThemeDarkColor = Color(0xFF0A0A0A); // (10, 10, 10)
  static const Color ThemeBlueColor = Color(0xFF4688FA);
  static const Color ThemePurpleColor = Colors.purple;

  // 渐变色（appBar和按钮）
  static const Color GradientStartColor = Color(0xFF2683BE); // 渐变开始色
  static const Color GradientEndColor = Color(0xFF34CABE); // 渐变结束色

  // 渐变色
  // static const Color GradientStartColor = Color(0xFF2171F5); // 渐变开始色
  // static const Color GradientEndColor = Color(0xF000A2FC); // 渐变结束色

  // 导航条背景色（主题色背景白色文字，透明背景为黑色文字，暗黑模式是白色文字）
  static const Color NavThemeBgColor = ThemeColor;

  // 导航条背景色（白色背景色黑色文字，透明背景为黑色文字，暗黑模式是白色文字）
  static const Color NavWhiteBgColor = Color(0xFFEDEDED); //(237, 237, 237)
  static const Color NavBgDarkColor = ThemeDarkColor; // (10, 10, 10)
  static const Color NavTitleColor = Colors.white;

  // tabBar背景颜色
  static const Color TabBarBgColor = Colors.white;
  static const Color TabBarBgDarkColor = Color(0xFF1D1D1D); // (29, 29, 29)

  // tabBar默认文字颜色
  static const Color TabBarNormalTextColor = BlackTextColor;
  static const Color TabBarNormalTextDarkColor = BlackTextDarkColor;

  // tabBar选中文字颜色
  static const Color TabBarSelectTextColor = ThemeColor;
  static const Color TabBarSelectTextDarkColor = ThemeColor;

  // 背景色
  static const Color BgColor = Color(0xFFF8F8F8); // (248, 248, 248)
  static const Color BgDarkColor = Color(0xFF111111); // (17, 17, 17)

  // cell背景
  static const Color CellBgColor = Colors.white;
  static const Color CellBgDarkColor = Color(0xFF191919); // (25, 25, 25)

  static const Color MaterialBgColor = Color(0xFFFFFFFF); // (255, 255, 255)
  static const Color MaterialBgDarkColor = Color(0xFF303233); // (48, 50, 51)

  // btn背景颜色
  // static const Color BtnBgColor = ThemeColor;
  // static const Color BtnBgDarkColor = Color(0xFF2B2B2B); // (43, 43, 43)

  // 黑色文字
  static const Color BlackTextColor = Color(0xFF333333); // (51, 51, 51)
  static const Color BlackTextDarkColor = Color(0xFFC6C6C6); // (198, 198, 198)

  // 灰色文字
  static const Color GreyTextColor = Color(0xFF777777); // (119, 119, 119)
  static const Color GreyTextDarkColor = Color(0xFF787878); // (120, 120, 120)

  // 浅灰色文字
  static const Color LightGreyTextColor = Color(0xFF999999); // (153, 153, 153)
  static const Color LightGreyTextDarkColor =
      Color(0xFF666666); // (102, 102, 102)

  // 表单title文字
  static const Color FormTitleColor = BlackTextColor;
  static const Color FormTitleDarkColor = BlackTextDarkColor;

  // 表单info文字
  static const Color FormInfoColor = BlackTextColor;
  static const Color FormInfoDarkColor = BlackTextDarkColor;

  // 表单hint文字
  static const Color FormHintColor = Color(0xFFBBBBBB); // (187, 187, 187)
  static const Color FormHintDarkColor = Color(0xFF575757); // (87, 87, 87)

  // 表单分割线
  static const Color FormLineColor = LineColor;
  static const Color FormLineDarkColor = LineDarkColor;

  // 表单暗黑模式Focused状态下划线颜色
  static const Color FocusedBorderDarkColor = LineColor;

  // error颜色
  static const Color ErrorTextColor = Color(0xFFFF4759); // (255, 71, 89)
  static const Color ErrorTextDarkColor = Color(0xFFE03E4E); // (224, 62, 78)

  // 分割线
  static const Color LineColor = Color(0xFFE6E6E6); // (230, 230, 230)
  static const Color LineDarkColor = Color(0xFF232323); // (35, 35, 35)

  // 搜索框颜色
  static const Color SearchBarBgColor = CellBgColor;
  static const Color SearchBarBgDarkColor = CellBgDarkColor;

  // textView背景颜色
  static const Color TextViewBgColor = Color(0xFFFAFAFA); // (250, 250, 250)
  static const Color TextViewBgDarkColor = Color(0xFF323232); // (50, 50, 50)

  // toast背景颜色
  static const Color ToastBgColor = Colors.black87;
  static const Color ToastBgDarkColor = Color(0xFF2F2F2F); // (47, 47, 47)

  // alert背景颜色
  static const Color AlertBgColor = Colors.white;
  static const Color AlertBgDarkColor = Color(0xFF2C2C2C); // (44, 44, 44)
  static const Color AlertInputBgColor = Colors.white;
  static const Color AlertInputBgDarkColor = Color(0xFF1E1E1E); // (30, 30, 30)

  // picker、bottomSheet颜色
  static const Color PickerBgColor = Colors.white;
  static const Color PickerBgDarkColor = Color(0xFF1E1E1E); // (30, 30, 30)
  static const Color PickerTitleColor = Color(0xFF787878); // (120, 120, 120)
  static const Color PickerTitleDarkColor =
      Color(0xFF878787); // (135, 135, 135)
  static const Color PickerTextColor = BlackTextColor;
  static const Color PickerTextDarkColor = BlackTextDarkColor;
  static const Color PickerRedTextDarkColor =
      Color(0xFFE64242); // (230, 66, 66)
  static const Color PickerHeaderColor = PickerBgColor;
  static const Color PickerHeaderDarkColor = PickerBgDarkColor;
  static const Color PickerHeaderLineColor = LineColor;
  static const Color PickerHeaderLineDarkColor = LineDarkColor;
  static const Color PickerBtnColor = BlackTextColor;
  static const Color PickerBtnDarkColor = BlackTextDarkColor;

  // card颜色
  static const Color CardBgColor = Colors.white;
  static const Color CardBgDarkColor = Color(0xFF2C2C2C); // (44, 44, 44)

  // icon颜色
  static const Color IconColor = Color(0xFF646464); // (100, 100, 100)
  static const Color IconDarkColor = Color(0xFFC8C8C8); // (200, 200, 200)

  // 微信主题色 rgb(59,184,21)
  static const Color wxThemeColor = Color(0xFF3BB815);
  static const Color wxThemeDarkColor = Color(0xFF00BE66);

  static const Color wxTitleColor = Colors.white;

  // 微信背景色 rgb(237,237,237)
  static const Color wxBgColor = Color(0xFFEDEDED);

  // 深蓝色

  static const Color transparent = Colors.transparent;
}

class Colours {
  static const Color white = Colors.white;
  static const Color dark_app_main = Color(0xFF3F7AE0);

  static const Color bg_color = Color(0xfff1f1f1);
  static const Color dark_bg_color = Color(0xFF18191A);

  static const Color material_bg = Color(0xFFFFFFFF);
  static const Color dark_material_bg = Color(0xFF303233);

  static const Color gray = Color.fromRGBO(153, 153, 153, 1.0);

  static const Color inputBoxGray = Color.fromRGBO(248, 249, 251, 1);

  static const Color text = Color.fromRGBO(51, 51, 51, 1);
  static const Color dark_text = Color(0xFFB8B8B8);

  static const Color text_gray = Color(0xFF999999);
  static const Color dark_text_gray = Color.fromARGB(255, 43, 33, 33);

  static const Color text_gray_c = Color(0xFFcccccc);
  static const Color dark_button_text = Color(0xFFF2F2F2);

  static const Color bg_gray = Color(0xFFF6F6F6);
  static const Color dark_bg_gray = Color(0xFF1F1F1F);

  static const Color line = Color(0xFFEEEEEE);
  static const Color dark_line = Color(0xFF3A3C3D);

  static const Color red = Color(0xFFFF4759);
  static const Color dark_red = Color(0xFFE03E4E);

  static const Color text_disabled = Color(0xFFD4E2FA);
  static const Color dark_text_disabled = Color(0xFFCEDBF2);

  static const Color button_disabled = Color(0xFF96BBFA);
  static const Color dark_button_disabled = Color(0xFF83A5E0);

  static const Color unselected_item_color = Color(0xffbfbfbf);
  static const Color dark_unselected_item_color = Color(0xFF4D4D4D);

  static const Color bg_gray_ = Color(0xFFFAFAFA);
  static const Color dark_bg_gray_ = Color(0xFF242526);
}
