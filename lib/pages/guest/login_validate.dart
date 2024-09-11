import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/strings.dart';
import 'package:wg_pro_002/pages/guest/login_or_register.dart';
import 'package:wg_pro_002/pages/guest/set_password.dart';
import 'package:wg_pro_002/provider/guest_provider.dart';
import 'package:wg_pro_002/utils/common_utils.dart';

class LoginValidate extends StatefulWidget {
  static const String sName = "loginValidate";

  const LoginValidate({super.key});

  @override
  _LoginValidateState createState() => _LoginValidateState();
}

class _LoginValidateState extends State<LoginValidate> {
  final int optNumCount = 6;

  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

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
  void initState() {
    super.initState();
    for (int i = 0; i < optNumCount; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < optNumCount; i++) {
      controllers[i].dispose();
      focusNodes[i].dispose();
    }
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
                      "Verification",
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
                sendNewValidCode(),
                const Gap(10),
                submitButton(guesetProvider),
                const Gap(30),
                bottomRemind(context, guesetProvider)
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget sendNewValidCode() {
    return TextButton(
      onPressed: () {
        // 这里添加您要执行的代码，比如页面跳转或显示对话框
        CommonUtils.showToast("sent succefully");
      },
      style: TextButton.styleFrom(
          // backgroundColor: Colors.blue, // 背景颜色
          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // 内边距
          ),
      child: const Text("Send new code"),
    );
  }

  Padding phoneDescPadding(GuestProvider guesetProvider) {
    String phone = guesetProvider.guestPhone;
    double paddingSide = (MathUtils.screenWidth / 10);
    return Padding(
      padding: EdgeInsets.only(
          left: paddingSide, top: 30, bottom: 15, right: paddingSide),
      child: Center(
        // 使用 Center 包裹 Text 来确保水平居中
        child: Text(
          "Please, enter code from SMS which we sent on $phone",
          textAlign: TextAlign.center, // 设置文本对齐方式为居中
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromRGBO(153, 153, 153, 1.0),
          ),
        ),
      ),
    );
  }

  Padding inputCellPadding(GuestProvider guesetProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 36, right: 36, bottom: 10),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(optNumCount, (index) => otpTextField(index)),
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
            String smsCode = getFullCode();
            if (smsCode.length < 6) {
              CommonUtils.showToast("plz finish to input your sms code");
            }
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SetPassword()));
          },
          child: const Text(Strings.Login, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  Widget otpTextField(int index) {
    double size =
        (MathUtils.screenWidth - 72 - (optNumCount + 1) * 8) / optNumCount;

    return Expanded(
      child: Container(
        height: size, // 控制高度
        width: size,
        margin: const EdgeInsets.all(4), // 控制周围间距
        decoration: BoxDecoration(
          color: Colours.inputBoxGray, // 背景色
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace &&
                  controllers[index].text.isEmpty &&
                  index > 0) {
                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
              }
            },
            child: TextField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              decoration: const InputDecoration(
                counterText: "", // 隐藏底部的字符计数
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1 && index < optNumCount - 1) {
                  // 当前框填满时，自动移动焦点到下一个框
                  FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                } else if (value.isEmpty && index > 0) {
                  // 当前框清空时，且不是第一个框时，将焦点回退到前一个框
                  FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                }
              },
              onSubmitted: (value) {
                if (value.isEmpty && index > 0) {
                  // 用户可能使用键盘的提交操作，在移动到前一个框时清空其内容
                  controllers[index - 1].text = '';
                  FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                }
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getFullCode() {
    String fullCode = '';
    for (TextEditingController controller in controllers) {
      fullCode += controller.text;
    }
    return fullCode;
  }

//底部弹窗
  void _showVerificationBottomSheet(
      BuildContext context, GuestProvider guesetProvider) {
    String? phone = guesetProvider.guestPhone;
    double height = MathUtils.screenHeight * 0.5;
    showModalBottomSheet(
      isScrollControlled: true, // 允许弹窗高度为全屏
      backgroundColor: Colors.transparent, // 使得弹窗背景透明,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: height, // 调整为所需的高度
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Gap(height * 0.1),
              Container(
                width: MathUtils.screenWidth * 0.3, // 固定宽度
                height: MathUtils.screenWidth * 0.3, // 固定高度
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('static/images/change_phone.png'), // 本地图片
                    fit: BoxFit.cover, // 覆盖整个容器区域
                  ),
                ),
              ),
              const Gap(10),
              const Text(
                "更换手机号",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(height * 0.1),
              Text(
                "Mengubah nomor ponsel Anda mengharuskan Anda mengirimkan ulang informas $phone",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 设置按钮间的间隔
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // 关闭弹窗
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              width: 2.0, color: WGColors.ThemeColor), // 添加边框
                        ),
                        child: const Text("取消"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          guesetProvider.setGuestPhone("");
                          //todo 清除guest token
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginOrRegister()),
                            (Route<dynamic> route) => false, // 没有页面会保留在堆栈中
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: WGColors.ThemeColor, // 按钮背景色
                        ),
                        child: const Text(
                          "更换",
                          style: TextStyle(color: Colours.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer()
            ],
          ),
        );
      },
    );
  }

  Widget bottomRemind(BuildContext context, GuestProvider guesetProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 16),
          children: <InlineSpan>[
            const TextSpan(text: "Tidak dapat kode otp?\nSilahkan hubungi cs "),
            WidgetSpan(
              child: Material(
                color: Colors.transparent, // 确保 Material 背景透明
                child: InkWell(
                  onTap: () => print("Kontak Person被点击了!"),
                  child: const Text(
                    "Kontak Person",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const TextSpan(text: " / "),
            WidgetSpan(
              child: Material(
                color: Colors.transparent, // 确保 Material 背景透明
                child: InkWell(
                  onTap: () => print("WhatsApp被点击了!"),
                  child: const Text(
                    "WhatsApp",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const TextSpan(text: " \nor "),
            WidgetSpan(
              child: Material(
                color: Colors.transparent, // 确保 Material 背景透明
                child: InkWell(
                  onTap: () =>
                      _showVerificationBottomSheet(context, guesetProvider),
                  child: const Text(
                    "Ubah nomor ponsel An",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
            //
          ],
        ),
      ),
    );
  }
}
