import 'package:flutter/material.dart';
import 'package:wg_pro_002/pages/home_page.dart';
import 'package:wg_pro_002/pages/details_page.dart';
import 'package:wg_pro_002/pages/settings_page.dart';

class AppRouterDelegate extends RouterDelegate<RouteSettings>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteSettings> {
  final GlobalKey<NavigatorState> navigatorKey;

  RouteSettings? _currentRoute;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  RouteSettings? get currentConfiguration => _currentRoute;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(child: HomePage()),
        if (_currentRoute?.name == '/details')
          MaterialPage(
            child: DetailsPage(id: _currentRoute?.arguments as String),
          ),
        if (_currentRoute?.name == '/settings')
          MaterialPage(child: SettingsPage()),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        _currentRoute = null;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RouteSettings configuration) async {
    _currentRoute = configuration;
    notifyListeners();
  }

  @override
  Future<bool> popRoute() {
    if (_currentRoute != null) {
      _currentRoute = null;
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }
}
