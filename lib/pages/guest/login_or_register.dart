import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/app_assets.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/config/strings.dart';
import 'package:wg_pro_002/pages/guest/input_login_psword.dart';
import 'package:wg_pro_002/provider/guest_provider.dart';
import 'package:wg_pro_002/widget/form/wg_form.dart';

class LoginOrRegister extends StatefulWidget {
  static const String sName = "loginOrRegister";

  const LoginOrRegister({super.key});

  @override
  _LoginOrRegisterPageState createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegister> {
  final TextEditingController phoneController = TextEditingController();

  final FocusNode _phoneNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // return KeyboardActions(
    //   config: WgKeyboardUtils.getKeyboardConfig(context, [_phoneNode]),
    //   child: _body(),
    // );
    return _body();
  }

  @override
  void dispose() {
    print("page 1 disposed");
    _phoneNode.dispose();
    super.dispose();
  }

  _body() {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              color: WGColors.ThemeColor, // 使用您想要的颜色进行填充
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, top: 0),
              child: Stack(children: <Widget>[
                Positioned(
                    top: 0, // 可以调整这个值来控制文本位置
                    right: -10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Image.asset(
                          "${Config.BASE_APP_ASSETS_PATH}app_logo.png",
                          width: MathUtils.screenWidth * 3 / 5, // 指定图片宽度
                          height: MathUtils.screenWidth * 3 / 5, // 指定图片高度
                          fit: BoxFit.cover, // 保证图片覆盖整个容器区域
                        ),
                      ],
                    )),
                const Positioned(
                    top: 0, // 可以调整这个值来控制文本位置
                    left: 0, // 可以调整这个值来控制文本位置
                    child: Row(children: <Widget>[
                      Text(
                        "Welcome",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ])),
              ])),
          main_content()
        ],
      ),
    );
  }

  Widget main_content() {
    return Consumer<GuestProvider>(
        builder: (BuildContext context, guesetProvider, Widget? child) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MathUtils.screenHeight * 2 / 3,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                inputRequireDescPadding(),
                inputCellPadding(guesetProvider),
                const Gap(30),
                submitButton(guesetProvider),
                privacyAgreementPadding(guesetProvider)
              ],
            ),
          ),
        ),
      );
    });
  }

  Padding inputRequireDescPadding() {
    return const Padding(
      padding: EdgeInsets.only(left: 20, top: 30, bottom: 15, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Please enter your phone number",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(153, 153, 153, 1.0),
              )),
        ],
      ),
    );
  }

  Padding inputCellPadding(GuestProvider guesetProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 10),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 238, 235, 235),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.phone_android_outlined), // 图标
            ),
            const Text('+62'),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: WgFormInputCell(
                text: guesetProvider.guestPhone,
                bgColor: Colors.transparent,
                hiddenLine: true,
                keyboardType: TextInputType.phone,
                focusNode: _phoneNode,
                inputFormatters: [number],
                inputCallBack: (value) {
                  print("+++++");
                },
                inputCompletionCallBack: (value, isSubmitted) {
                  guesetProvider.setGuestPhone(value);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget submitButton(GuestProvider guesetProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: SizedBox(
        width: MathUtils.screenWidth * 0.75, // 指定按钮宽度
        height: 50, // 指定按钮高度
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: WGColors.ThemeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            // 当按钮被点击时，调用 inputCompletionCallBack
            if (_phoneNode.hasFocus) {
              _phoneNode.unfocus(); // 可以选择性地取消焦点
            }
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const InputLoginPsword()));
          },
          child: const Text(Strings.LoginOrRegester,
              style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  Widget privacyAgreementPadding(GuestProvider guesetProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: <Widget>[
          // 圆形的复选框
          Checkbox(
            value: guesetProvider.isReadPrivacyAgreement,
            onChanged: (bool? newValue) {
              guesetProvider.setPrivacyAgreement();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50), // 圆形边框
            ),
          ),
          // 超链接文本
          Expanded(
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '我已阅读并同意',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                    text: '《隐私协议》',
                    style: TextStyle(
                      color: Colors.blue, // 设置链接颜色
                      decoration: TextDecoration.underline, // 下划线
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
