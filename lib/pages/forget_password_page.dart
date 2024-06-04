import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wg_pro_002/common/app_colors.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/common/text_styles.dart';
import 'package:wg_pro_002/pages/common_pages/default_button.dart';
import 'package:wg_pro_002/pages/common_pages/default_field.dart';
import 'package:wg_pro_002/utils/logger_util.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
  }

  void navigateToSettings() {
    //LogUtils
    LogUtils.logInfo("This is an informational message:${emailController.text}");
    // (emailController.text)
    if (isValidEmail(emailController.text)) {
       Router
                    .of(context)
                    .routerDelegate
                    .setNewRoutePath(RouteSettings(name: '/settings'));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Email'),
          content: Text('Please enter a valid email address.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MathUtils.init(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(24)).copyWith(
          top: MediaQuery.of(context).viewPadding.top,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(32),
            Text(
              "Forgot password?",
              style: TextStyles.headingH4SemiBold.copyWith(
                  color: Pallete.neutral100, fontSize: getFontSize(32)),
            ),
            const Gap(8),
            Text(
              "Enter your email address and we’ll send you confirmation code to reset your password",
              style: TextStyles.bodyMediumMedium.copyWith(
                  color: Pallete.neutral60, fontSize: getFontSize(14)),
            ),
            // const Gap(32),
            DefaultField(
              hintText: "Enter Email",
              controller: emailController,
              labelText: "Email Address",
            ),
            const Spacer(),
            DefaultButton(
              btnContent: "Continue",
              function: navigateToSettings,
            ),
            const Gap(32),
          ],
        ),
      ),
    );
  }
}
