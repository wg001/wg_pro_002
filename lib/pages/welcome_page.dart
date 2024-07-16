import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';

import 'package:redux/redux.dart';
import 'package:rive/rive.dart';
import 'package:wg_pro_002/provider/user_auth_provider.dart';
import 'package:wg_pro_002/redux/wg_state.dart';
import 'package:wg_pro_002/style/gsy_style.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';
import 'package:wg_pro_002/widget/diff_scale_text.dart';
import 'package:wg_pro_002/widget/mole_widget.dart';

/// 欢迎页

class WelcomePage extends StatefulWidget {
  static const String sName = "/";

  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  String text = "";
  double fontSize = 76;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        text = "Welcome";
        fontSize = 60;
      });
    });
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        text = "WGApp";
        fontSize = 60;
      });
    });
    Future.delayed(const Duration(seconds: 3, milliseconds: 500), () {

    NavigatorUtils.goMainPage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<WGState>(
      builder: (context, store) {
        double size = 200;
        return Material(
          child: Container(
            color: WGColors.white,
            child: Stack(
              children: <Widget>[
                const Center(
                  child: Image(image: AssetImage('static/images/welcome.png')),
                ),
                Align(
                  alignment: const Alignment(0.0, 0.3),
                  child: DiffScaleText(
                    text: text,
                    textStyle: GoogleFonts.akronim().copyWith(
                      color: WGColors.primaryDarkValue,
                      fontSize: fontSize,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment(0.0, 0.8),
                  child: Mole(),
                ),
                Align(
                  alignment: const Alignment(0.0, .9),
                  child: SizedBox(
                    width: size,
                    height: size,
                    child: RiveAnimation.asset(
                      'static/file/launch.riv',
                      animations: const ["lookUp"],
                      onInit: (arb) {
                        var controller =
                            StateMachineController.fromArtboard(arb, "birb");
                        var smi = controller?.findInput<bool>("dance");
                        arb.addController(controller!);
                        smi?.value == true;
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
