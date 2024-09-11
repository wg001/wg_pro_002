import 'package:flutter/material.dart';
import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_attribution.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event_failure.dart';
import 'package:adjust_sdk/adjust_event_success.dart';
import 'package:adjust_sdk/adjust_session_failure.dart';
import 'package:adjust_sdk/adjust_session_success.dart';

class AppDataProvider with ChangeNotifier {
  String? _adid;
  String? get adjustAdid => _adid;
  initAdjust() async {
    AdjustConfig config =
        AdjustConfig('ffrs81ypeqrk', AdjustEnvironment.sandbox);

    // start SDK
    Adjust.initSdk(config);
  }

  fetchAdjustAdid() async {
    Adjust.getAdid().then((adid) {
      _adid = adid;
      print('获取adid成功$adid');
    });
  }
}
