import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// 通用逻辑

typedef StringList = List<String>;

class CommonUtils {
  static const double MILLIS_LIMIT = 1000.0;

  static const double SECONDS_LIMIT = 60 * MILLIS_LIMIT;

  static const double MINUTES_LIMIT = 60 * SECONDS_LIMIT;

  static const double HOURS_LIMIT = 24 * MINUTES_LIMIT;

  static const double DAYS_LIMIT = 30 * HOURS_LIMIT;

  static final bool isWeb = kIsWeb;
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

  static InputDecoration getInputDecoration({
    required String label,
    String? hintText,
    TextStyle? labelStyle,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hintText,
      labelStyle:
          labelStyle ?? const TextStyle(fontSize: 17, color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            BorderSide(color: Colors.orange.withOpacity(0.5), width: 1.0),
      ),
    );
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

  static String? removeTextTag(String? description) {
    if (description != null) {
      String reg = "<g-emoji.*?>.+?</g-emoji>";
      RegExp tag = RegExp(reg);
      Iterable<Match> tags = tag.allMatches(description);
      for (Match m in tags) {
        String match = m
            .group(0)!
            .replaceAll(RegExp("<g-emoji.*?>"), "")
            .replaceAll(RegExp("</g-emoji>"), "");
        description = description!.replaceAll(RegExp(m.group(0)!), match);
      }
    }
    return description;
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

  static splitFileNameByPath(String path) {
    return path.substring(path.lastIndexOf("/"));
  }

  static getFullName(String? repository_url) {
    if (repository_url != null &&
        repository_url.substring(repository_url.length - 1) == "/") {
      repository_url = repository_url.substring(0, repository_url.length - 1);
    }
    String fullName = '';
    if (repository_url != null) {
      StringList splicurl = repository_url.split("/");
      if (splicurl.length > 2) {
        fullName =
            "${splicurl[splicurl.length - 2]}/${splicurl[splicurl.length - 1]}";
      }
    }
    return fullName;
  }

  static getThemeData(Color color) {
    return ThemeData(
      ///用来适配 Theme.of(context).primaryColorLight 和 primaryColorDark 的颜色变化，不设置可能会是默认蓝色
      primarySwatch: color as MaterialColor,

      /// Card 在 M3 下，会有 apply Overlay

      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
        primary: color,

        brightness: Brightness.light,

        ///影响 card 的表色，因为 M3 下是  applySurfaceTint ，在 Material 里
        surfaceTint: Colors.transparent,
      ),

      /// 受到 iconThemeData.isConcrete 的印象，需要全参数才不会进入 fallback
      iconTheme: const IconThemeData(
        size: 24.0,
        fill: 0.0,
        weight: 400.0,
        grade: 0.0,
        opticalSize: 48.0,
        color: Colors.white,
        opacity: 0.8,
      ),

      ///修改 FloatingActionButton的默认主题行为
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: color,
          shape: const CircleBorder()),
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 24.0,
        ),
        backgroundColor: color,
        titleTextStyle: Typography.dense2021.titleLarge,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // 如果需要去除对应的水波纹效果
      // splashFactory: NoSplash.splashFactory,
      // textButtonTheme: TextButtonThemeData(
      //   style: ButtonStyle(splashFactory: NoSplash.splashFactory),
      // ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ButtonStyle(splashFactory: NoSplash.splashFactory),
      // ),
    );
  }

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
                        Text("gogogog"),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  static showCommonListOptionBottomSheet(
      BuildContext context,
      String remindTip,
      Future<List<CommonListOption>> listData,
      Function(String, String) onUpdateSelectedValue,
      {Alignment align = Alignment.centerLeft}) {
    if (kDebugMode) {
      print('_showCommonListOptionBottomSheet:$listData');
    }

    // Temporarily store the selected option
    CommonListOption? tempSelectedOption;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 320, // Adjusted height for the title bar
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Title bar with Cancel, Title, and Confirm buttons
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black26,
                        spreadRadius: 5,
                      )
                    ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Text(remindTip,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16)),
                        ),
                        CupertinoButton(
                          child: Text('Confirm'),
                          onPressed: () {
                            if (tempSelectedOption != null) {
                              onUpdateSelectedValue(
                                  tempSelectedOption!.id ?? '',
                                  tempSelectedOption!.value ?? '');
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<CommonListOption>>(
                      future: listData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CupertinoActivityIndicator());
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No Data Available'));
                        }

                        return CupertinoPicker(
                          itemExtent: 36.0,
                          onSelectedItemChanged: (int index) {
                            tempSelectedOption = snapshot.data![index];
                          },
                          magnification: 1.2,
                          useMagnifier: true,
                          backgroundColor: Colors.white,
                          children: snapshot.data!
                              .map((option) => Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0), // 增加垂直内边距进行调整
                                      child: Text(option.value ?? "",
                                          style: const TextStyle(
                                              fontSize: 16) // 根据需要调整字体大小
                                          ),
                                    ),
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
