import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wg_pro_002/provider/welcome_page.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';

/// 欢迎页

class WelcomePage extends StatelessWidget {
  static const String sName = "/";

  const WelcomePage({super.key});

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WelcomeProvider(
        onNavigate: () => NavigatorUtils.goMainPage(context),
      ),
      child: Consumer<WelcomeProvider>(
        builder: (context, provider, child) {
          return Material(
            child: Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Image.asset('static/images/welcome.png'),
                  ),
                  Align(
                    alignment: Alignment(0.0, 0.3),
                    child: Text(
                      provider.text,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: provider.fontSize,
                      ),
                    ),
                  ),
                  // Other Widgets
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
