import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/app/app.dart';
import 'package:wg_pro_002/provider/app_data_provider.dart';
import 'package:wg_pro_002/provider/camera_provider.dart';
import 'package:wg_pro_002/provider/guest_provider.dart';
import 'package:wg_pro_002/provider/home_page_provider.dart';
import 'package:wg_pro_002/provider/navigation_provider.dart';
import 'package:wg_pro_002/provider/theme_provider.dart';
import 'package:wg_pro_002/provider/user_auth_provider.dart';
import 'package:wg_pro_002/provider/user_info_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAuthNotifier()),
        ChangeNotifierProvider(create: (context) => HomePageProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => UserInfoProvider()),
        ChangeNotifierProvider(create: (context) => CameraProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => GuestProvider()),
        ChangeNotifierProvider(create: (context) => AppDataProvider()),
      ],
      child: const WgGoApp(),
    ),
  );
}
