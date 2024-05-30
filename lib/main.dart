import 'package:flutter/material.dart';
import 'package:wg_pro_002/app/router/app_route_information_parser.dart';
import 'package:wg_pro_002/app/router/app_router_delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouterDelegate = AppRouterDelegate();
  final _appRouteInformationParser = AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerDelegate: _appRouterDelegate,
      routeInformationParser: _appRouteInformationParser,
      debugShowCheckedModeBanner: false,
    );
  }
}
