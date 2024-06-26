import 'package:flutter/material.dart';
import 'package:wg_pro_002/app/app.dart';
import 'package:wg_pro_002/app/router/app_route_information_parser.dart';
import 'package:wg_pro_002/app/router/app_router_delegate.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/env/config_wrapper.dart';
import 'package:wg_pro_002/env/dev.dart';
import 'package:wg_pro_002/env/env_config.dart';

void main() {
  runApp(ConfigWrapper(
    config: EnvConfig.fromJson(config),
    child: const FlutterReduxApp(),
  ));
}

