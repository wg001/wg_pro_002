import 'package:flutter/material.dart';
import 'app_route_path.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    // Handle '/'
    if (uri.pathSegments.isEmpty) {
      return AppRoutePath.home();
    }

    // Handle '/details/:id'
    if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'details') {
      var id = int.tryParse(uri.pathSegments[1]);
      if (id != null) return AppRoutePath.details(id);
    }

    // Handle '/settings'
    if (uri.pathSegments.length == 1 && uri.pathSegments.first == 'settings') {
      return AppRoutePath.settings();
    }

    // Handle unknown routes
    return AppRoutePath.home();
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoutePath path) {
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.id != null) {
      return RouteInformation(location: '/details/${path.id}');
    }
    if (path.id == null && !path.isHomePage) {
      return RouteInformation(location: '/settings');
    }
    return null;
  }
}
