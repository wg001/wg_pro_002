import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

/// 通用逻辑

typedef StringList = List<String>;

class CommonUtils {
  static const double MILLIS_LIMIT = 1000.0;

  static const double SECONDS_LIMIT = 60 * MILLIS_LIMIT;

  static const double MINUTES_LIMIT = 60 * SECONDS_LIMIT;

  static const double HOURS_LIMIT = 24 * MINUTES_LIMIT;

  static const double DAYS_LIMIT = 30 * HOURS_LIMIT;

  static const bool isWeb = kIsWeb;
  static final bool isIOS = !isWeb && Platform.isIOS;
  static final bool isAndroid = !isWeb && Platform.isAndroid;

  static Locale? curLocale;

  static String getDateStr(DateTime? date) {
    if (date == null || date.toString() == "") {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }

  static getApplicationDocumentsPath() async {
    Directory appDir;
    if (Platform.isIOS) {
      appDir = await getApplicationDocumentsDirectory();
    } else {
      appDir = await getApplicationSupportDirectory();
    }
    String appDocPath = "${appDir.path}/gsygithubappflutter";
    Directory appPath = Directory(appDocPath);
    await appPath.create(recursive: true);
    return appPath.path;
  }

  /*static saveImage(String url) async {
    Future<String> _findPath(String imageUrl) async {
      final file = await Cache.DefaultCacheManager().getSingleFile(url);
      if (file == null) {
        return null;
      }
      Directory localPath = await CommonUtils.getLocalPath();
      if (localPath == null) {
        return null;
      }
      final name = splitFileNameByPath(file.path);
      final result = await file.copy(localPath.path + name);
      return result.path;
    }

    return _findPath(url);
  }*/

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG);
  }

  static Future<void> showLoadingDialog(BuildContext context) {
    return NavigatorUtils.showWGDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
              color: Colors.transparent,
              child: PopScope(
                canPop: false,
                child: Center(
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      //用一个BoxDecoration装饰器提供背景图片
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SpinKitCubeGrid(color: Colors.white),
                        Container(height: 10.0),
                        const Text("gogogog"),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  static void showDatePicker(
    BuildContext context,
    Function(DateTime) onComplete,
  ) {
    picker.DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1949),
      maxTime: DateTime.now().add(const Duration(days: 365)), // 举例：未来一年内可选
      theme: const picker.DatePickerTheme(
        itemStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        doneStyle: TextStyle(
          fontSize: 16,
          color: Colors.blue, // 确认按钮颜色
        ),
      ),
      onConfirm: (date) {
        onComplete(date); // 用户确认后，调用 onComplete 回调函数
      },
      currentTime: DateTime.now(), // 默认显示当前时间
      locale: picker.LocaleType.en, // 设置本地化
    );
  }

  static void showCustomDialog({
    required String title,
    required BuildContext context,
    required Widget content, // 接收一个Widget作为显示内容
    VoidCallback? onClose, // 关闭按钮的回调
    VoidCallback? onContinue, // 继续按钮的回调
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), // 设置圆角
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                          color: Color.fromRGBO(51, 51, 51, 1), fontSize: 16),
                    ),
                    const Gap(10),
                    content, // 使用传入的内容
                    const Gap(20),
                    TextButton(
                      onPressed: () {
                        if (onContinue != null) {
                          onContinue();
                        } else {
                          Navigator.of(context).pop(); // 如果没有特定的继续操作，关闭对话框
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: WGColors.ThemeColor,
                      ),
                      child: SizedBox(
                          width: MathUtils.screenWidth * 0.5,
                          height: 30,
                          child: const Center(
                            child: Text(
                              "继续上传",
                              style: TextStyle(fontSize: 15),
                            ),
                          )),
                    ),
                    const Gap(10),
                  ],
                ),
              ),
              Positioned(
                right: 5.0,
                top: 5.0,
                child: InkResponse(
                  onTap: () {
                    if (onClose != null) {
                      onClose(); // 使用传入的关闭回调
                    } else {
                      Navigator.of(context).pop(); // 如果没有特定的关闭操作，关闭对话框
                    }
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.close,
                        color: Color.fromRGBO(197, 197, 197, 1)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
