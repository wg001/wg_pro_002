import 'package:flutter/material.dart';

class AppRouteInformationParser extends RouteInformationParser<RouteSettings> {
  @override
  Future<RouteSettings> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isEmpty) {
      return RouteSettings(name: '/');
    }

    if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'details') {
      final id = uri.pathSegments[1];
      return RouteSettings(name: '/details', arguments: id);
    }

    if (uri.pathSegments.first == 'settings') {
      return RouteSettings(name: '/settings');
    }

    return RouteSettings(name: '/');
  }

  @override
  RouteInformation? restoreRouteInformation(RouteSettings configuration) {
    if (configuration.name == '/') {
      return RouteInformation(location: '/');
    }

    if (configuration.name == '/details') {
      return RouteInformation(location: '/details/${configuration.arguments}');
    }

    if (configuration.name == '/settings') {
      return RouteInformation(location: '/settings');
    }

    return null;
  }
}
