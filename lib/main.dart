import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/app/app.dart';
import 'package:wg_pro_002/app/router/app_route_information_parser.dart';
import 'package:wg_pro_002/app/router/app_router_delegate.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/env/config_wrapper.dart';
import 'package:wg_pro_002/env/dev.dart';
import 'package:wg_pro_002/env/env_config.dart';
import 'package:wg_pro_002/provider/home_page_provider.dart';
import 'package:wg_pro_002/provider/navigation_provider.dart';
import 'package:wg_pro_002/provider/user_auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAuthNotifier()),
        ChangeNotifierProvider(create: (context) => HomePageProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ],
      child: WgGoApp(),
    ),
  );
}
