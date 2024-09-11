import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/app_assets.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/config/strings.dart';
import 'package:wg_pro_002/pages/main_page.dart';
import 'package:wg_pro_002/provider/guest_provider.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';
import 'package:wg_pro_002/widget/form/wg_form.dart';

class SetPassword extends StatefulWidget {
  static const String sName = "setPassword";

  const SetPassword({super.key});

  @override
  _SetPswordState createState() => _SetPswordState();
}

class _SetPswordState extends State<SetPassword> {
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();
  GuestProvider? guestProvider;

  @override
  void initState() {
    super.initState();
    guestProvider = Provider.of<GuestProvider>(context, listen: false);
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

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
    // guestProvider?.setErrMsg("", refreshPage: false);
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    // passwordController.dispose();
    // confirmPasswordController.dispose();
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
                        "${Config.BASE_APP_ASSETS_PATH}app_logo.png",
                        width: MathUtils.screenWidth * 3 / 5, // 指定图片宽度
                        height: MathUtils.screenWidth * 3 / 5, // 指定图片高度
                        fit: BoxFit.cover, // 保证图片覆盖整个容器区域
                      ),
                    ],
                  )),
            ])),
        mainContent()
      ],
    );
  }

  Widget mainContent() {
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
                setPasswordRemindTips(guesetProvider),
                const Gap(10),
                inputCellPadding(passwordController, Strings.SetPasswordInput,
                    _passwordNode),
                inputCellPadding(confirmPasswordController,
                    Strings.SetPasswordInputConfirm, _confirmPasswordNode),
                passwordSetTip(),
                const Gap(50),
                submitButton(guesetProvider),
                const Gap(10),
                Text(
                  guesetProvider.doubleCheckSettingPasswordErrMsg,
                  style:
                      const TextStyle(color: WGColors.ThemeColor, fontSize: 15),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Padding passwordSetTip() {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              Strings.SetPasswordTip,
              style: TextStyle(color: Colours.gray),
            ),
          ],
        ));
  }

  Padding setPasswordRemindTips(GuestProvider guesetProvider) {
    String phone = guesetProvider.guestPhone;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: RichText(
        textAlign: TextAlign.center, // 添加这行来设置文本对齐方式为居中

        text: TextSpan(
          children: <InlineSpan>[
            const TextSpan(
                text: "为了你的账号安全\n请设置 ",
                style: TextStyle(color: Colours.gray, fontSize: 15)),
            TextSpan(
                text: phone,
                style: const TextStyle(color: Colours.text, fontSize: 15)),
            const TextSpan(
                text: "的登录密码 ",
                style: TextStyle(color: Colours.gray, fontSize: 15)),
            //
          ],
        ),
      ),
    );
  }

  Padding inputCellPadding(
      TextEditingController controller, String hintText, FocusNode focusNode) {
    // 输出控制器和焦点节点的状态，帮助调试
    print('Building input field with hintText: $hintText');
    print('Focus node has listeners: ${focusNode.hasListeners}');
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
                controller: controller,
                keyboardType: TextInputType.text,
                focusNode: focusNode,
                border: InputBorder.none,
                hintText: hintText,
                isPwd: true,
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
          onPressed: () async {
            // 当按钮被点击时，调用 inputCompletionCallBack
            if (_passwordNode.hasFocus) {
              _passwordNode.unfocus(); // 可以选择性地取消焦点
            }
            if (_confirmPasswordNode.hasFocus) {
              _confirmPasswordNode.unfocus(); // 可以选择性地取消焦点
            }
            if (!mounted) {
              print(">>>>>>>");
              return;
            }
            guesetProvider.checkSettingPassword(
                passwordController.text, confirmPasswordController.text);

            print("hahah ${passwordController.text}");
            print("vvvvv ${confirmPasswordController.text}");
            // Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(builder: (context) => const MainPage()));
            NavigatorUtils.goMainPage(context);
          },
          child: const Text(Strings.Login, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
