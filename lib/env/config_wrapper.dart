import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/env/env_config.dart';

class ConfigWrapper extends StatelessWidget {
  final EnvConfig? config;
  final Widget? child;

  const ConfigWrapper({super.key, this.config, this.child});

  @override
  Widget build(BuildContext context) {
    Config.DEBUG = config?.debug;
    if (kDebugMode) {
      print("ConfigWrapper build ${Config.DEBUG}");
    }
    return _InheritedConfig(config: config, child: child!);
  }
}

class _InheritedConfig extends InheritedWidget {
  const _InheritedConfig({required this.config, required super.child});

  final EnvConfig? config;

  @override
  bool updateShouldNotify(_InheritedConfig oldWidget) =>
      config != oldWidget.config;
}
