import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/strings.dart';
import 'package:wg_pro_002/pages/guest/login_validate.dart';
import 'package:wg_pro_002/provider/guest_provider.dart';
import 'package:wg_pro_002/widget/form/wg_form.dart';

class InputLoginPsword extends StatefulWidget {
  static const String sName = "inputLoginPsword";

  const InputLoginPsword({super.key});

  @override
  _InputLoginPswordState createState() => _InputLoginPswordState();
}

class _InputLoginPswordState extends State<InputLoginPsword> {
  final TextEditingController phoneController = TextEditingController();

  final FocusNode _passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // return KeyboardActions(
    //   config: WgKeyboardUtils.getKeyboardConfig(context, [_phoneNode]),
    //   child: _body(),
    // );
    return Scaffold(
      appBar: AppBar(),
      body: _body(),
    );
  }

  @override
  void dispose() {
    print("page 1 disposed");
    _passwordNode.dispose();
    super.dispose();
  }

  _body() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            color: WGColors.ThemeColor, // 使用您想要的颜色进行填充
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Stack(children: <Widget>[
              Positioned(
                  top: 0, // 可以调整这个值来控制文本位置
                  right: -10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(
                        "static/images/app_logo.png",
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
                phoneDescPadding(guesetProvider),
                inputCellPadding(guesetProvider),
                const Gap(20),
                forgetPasswordTextButtong(),
                const Gap(10),
                submitButton(guesetProvider),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget forgetPasswordTextButtong() {
    return TextButton(
      onPressed: () {
        // 这里添加您要执行的代码，比如页面跳转或显示对话框
        print("TextButton was tapped!");
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoginValidate()));
      },
      style: TextButton.styleFrom(
          // backgroundColor: Colors.blue, // 背景颜色
          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // 内边距
          ),
      child: const Text("忘记密码?"),
    );
  }

  Padding phoneDescPadding(GuestProvider guesetProvider) {
    String phone = guesetProvider.guestPhone;
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 30, bottom: 15, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("请输入的$phone登录密码",
              textAlign: TextAlign.left,
              style: const TextStyle(
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
              child: Icon(
                Icons.lock, color: Colours.gray, // 设置图标颜色为蓝色
              ), // 图标
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: WgLoginTextField(
                text: guesetProvider.password,
                keyboardType: TextInputType.text,
                focusNode: _passwordNode,
                border: InputBorder.none,
                isPwd: true,
                inputCallBack: (value) {
                  print("+++++");
                },
                inputCompletionCallBack: (value, isSubmitted) {
                  print("===$value");
                  guesetProvider.setPassword(value);
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
            if (_passwordNode.hasFocus) {
              _passwordNode.unfocus(); // 可以选择性地取消焦点
            }
          },
          child: const Text(Strings.Login, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
