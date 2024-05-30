import 'package:flutter/material.dart';
import 'package:wg_pro_002/pages/home_page.dart';
import 'package:wg_pro_002/pages/details_page.dart';
import 'package:wg_pro_002/pages/settings_page.dart';
import 'app_route_path.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AppRoutePath _currentPath = AppRoutePath.home();

  @override
  AppRoutePath get currentConfiguration => _currentPath;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(key: ValueKey('HomePage'), child: HomePage()),
        if (!_currentPath.isHomePage)
          MaterialPage(
              key: ValueKey('DetailsPage'),
              child: DetailsPage(id: _currentPath.id!)),
        // Add other pages here
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        _currentPath = AppRoutePath.home();
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    _currentPath = configuration;
  }

  // Add a method to handle navigation to the details page
  void handleNavigationToDetails(int id) {
    _currentPath = AppRoutePath.details(id);
    notifyListeners();
  }
}
