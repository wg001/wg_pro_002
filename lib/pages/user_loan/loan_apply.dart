import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/strings.dart';
import 'package:app_settings/app_settings.dart';
import 'package:wg_pro_002/pages/user_loan/loan_repay_schedule.dart';
import 'package:wg_pro_002/provider/user_info_provider.dart';
import 'package:wg_pro_002/utils/common_utils.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:wg_pro_002/widget/wg_webview.dart';

class LoanApply extends StatefulWidget {
  const LoanApply({super.key});

  @override
  _LoanApplyState createState() => _LoanApplyState();
}

class _LoanApplyState extends State<LoanApply> {
  final FocusNode _node1 = FocusNode();
  final FocusNode _node2 = FocusNode();

  bool _privacyRead = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<UserInfoProvider>(context, listen: false).loadUserData();
      }
    });
  }

  @override
  void dispose() {
    print("page 1 disposed");
    _node1.dispose();
    _node2.dispose();
    super.dispose(); // 确保父类的 dispose 方法被调用
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "确认申请",
          style: TextStyle(color: Colours.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white), // 设置图标主题，包括回退按钮颜色
        backgroundColor: Colors.transparent, // 设置 AppBar 背景透明
        elevation: 0, // 移除阴影
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    WGColors.ThemeColor, // 从主题颜色开始
                    Color.fromRGBO(249, 249, 249, 1) // 渐变到白色
                  ],
                  stops: [0.3, 0.3],
                ),
              ),
            ),
          ),
          _body(),
        ],
      ),
    );
  }

  Widget _body() {
    return Consumer<UserInfoProvider>(
      builder: (BuildContext context, userInfoProvider, Widget? child) {
        return SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Gap(10),
                  Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              color: Color.fromRGBO(255, 255, 255, 1)),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              _infoSection01(context),
                              _infoSection02(context),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              color: Color.fromRGBO(255, 255, 255, 1)),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              _infoSection03(context),
                              _infoSection04(context),
                            ],
                          ),
                        ),
                        _privacyAgreementPadding(),
                        _submitButton(),
                        const Gap(10)
                      ],
                    )),
                  ),
                ],
              ),
              // 固定在右下角的按钮
            ],
          ),
        );
      },
    );
  }

  Widget _infoSection02(BuildContext context) {
    TextStyle tsStyle =
        const TextStyle(fontSize: 15, color: Color.fromRGBO(51, 51, 51, 1));
    return Container(
        width: MathUtils.screenWidth,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "借款金额",
                      style: tsStyle,
                    ),
                    const Text(
                      "600,000",
                      style: TextStyle(
                          fontSize: 15, color: Color.fromRGBO(211, 182, 91, 1)),
                    ),
                  ]),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "借款期限",
                        style: tsStyle,
                      ),
                      Text("91天", style: tsStyle),
                    ])),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Biaya Administrasl",
                        style: tsStyle,
                      ),
                      Text("91天", style: tsStyle),
                    ])),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: [
                        Text(
                          "Simpanan Pokok",
                          style: tsStyle,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        _help01(context),
                      ]),
                      Text("91天", style: tsStyle),
                    ])),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            "Simpanan Wajib",
                            style: tsStyle,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          _help02(context),
                        ],
                      ),
                      Text("91天", style: tsStyle),
                    ])),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Dash(
                direction: Axis.horizontal,
                length: MathUtils.screenWidth -
                    20, // Overall length of the dashed line
                dashLength: 5, // Length of each dash segment
                dashColor: const Color.fromRGBO(
                    216, 216, 216, 1), // Color of the dashes
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Jumlah yg diterma",
                        style: tsStyle,
                      ),
                      Text("387,000", style: tsStyle),
                    ])),
          ],
        ));
  }

  Widget _help01(BuildContext context) {
    // 与之前相同
    return GestureDetector(
      onTap: () {
        CommonUtils.showToast("help01");
      },
      //  child: Image.asset('${Config.BASE_APP_ASSETS_PATH}deposit_help.png'));
      child: const Icon(
        Icons.help_outline,
        color: Color.fromRGBO(255, 192, 112, 1),
      ),
    );
  }

  Widget _help02(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('提示'),
            content: const Text('一些信息'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('确定'),
              ),
            ],
          ),
        );
      },
      //  child: Image.asset('${Config.BASE_APP_ASSETS_PATH}deposit_help.png'));
      child: const Icon(
        Icons.help_outline,
        color: Color.fromRGBO(255, 192, 112, 1),
      ),
    );
  }

  Widget _infoSection01(BuildContext context) {
    return Container(
      width: MathUtils.screenWidth,
      // height: ,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(253, 251, 238, 1),
          // color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: const Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: Row(children: [
              Text(
                "张三",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromRGBO(102, 102, 102, 1)),
              ),
            ]),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
              child: Row(children: [
                Text(
                  "330898******2234989",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromRGBO(102, 102, 102, 1)),
                ),
              ])),
        ],
      ),
    );
  }

  Widget _infoSection03(BuildContext context) {
    TextStyle txStyle = const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color.fromRGBO(102, 102, 102, 1));
    return Container(
      width: MathUtils.screenWidth,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(232, 232, 232, 1),
          // color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("期数", style: txStyle),
                  Text(
                    "日期",
                    style: txStyle,
                  ),
                  Text(
                    "张三",
                    style: txStyle,
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Widget _infoSection04(BuildContext context) {
    TextStyle txStyle =
        const TextStyle(fontSize: 15, color: Color.fromRGBO(102, 102, 102, 1));
    EdgeInsetsGeometry rowPadding =
        const EdgeInsets.symmetric(horizontal: 30, vertical: 10);
    return Container(
      width: MathUtils.screenWidth,
      decoration: const BoxDecoration(
          // color: Colors.black,
          ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: rowPadding,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("1", style: txStyle),
                  Text(
                    "29 Agustus 2022",
                    style: txStyle,
                  ),
                  Text(
                    "18880",
                    style: txStyle,
                  ),
                ]),
          ),
          Padding(
            padding: rowPadding,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("1", style: txStyle),
                  Text(
                    "29 June 2022",
                    style: txStyle,
                  ),
                  Text(
                    "18880",
                    style: txStyle,
                  ),
                ]),
          ),
          Padding(
            padding: rowPadding,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("1", style: txStyle),
                  Text(
                    "29 Agustus 2022",
                    style: txStyle,
                  ),
                  Text(
                    "18880",
                    style: txStyle,
                  ),
                ]),
          ),
          Padding(
              padding: rowPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(children: [
                    InkWell(
                      onTap: () {
                        CommonUtils.showToast("plan");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoanRepaySchedule()));
                        // 在这里执行你的点击后的逻辑
                      },
                      child: const Text(
                        'Repayment Plan',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(201, 33, 42, 1)),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color.fromRGBO(185, 185, 185, 1),
                    )
                  ])
                ],
              )),
        ],
      ),
    );
  }

  Widget _infoSection(UserInfoProvider userInfoProvider) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: const Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(children: <Widget>[
                Text(
                  Strings.BankInfo,
                  style: TextStyle(
                      color: Color.fromRGBO(229, 161, 30, 1), fontSize: 15),
                )
              ])),
        ],
      ),
    );
  }

  Widget _privacyAgreementPadding() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
              value: _privacyRead,
              onChanged: (bool? value) {
                setState(() {
                  _privacyRead = !_privacyRead;
                });
              },
              shape: const CircleBorder(),
              fillColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.orange; // 选中时的颜色
                  }
                  return const Color.fromRGBO(245, 245, 245, 1); // 未选中时的颜色
                },
              ),
              side: const BorderSide(
                  style: BorderStyle.solid,
                  color: Color.fromARGB(255, 236, 236, 235))),
          Flexible(
            // 使用 Flexible
            fit: FlexFit.loose, // 设置为 loose 允许内部内容小于剩余空间
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: '我已阅读并同意',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                    text: '《借款协议》',
                    style: const TextStyle(
                      color: Color.fromRGBO(201, 33, 42, 1),
                      decoration: TextDecoration.none,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WgWebview(
                            targetUrl: 'https://www.baidu.com',
                            barTitle: '借款协议',
                          ),
                        ));
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // 确保按钮高度为 50
                backgroundColor: WGColors.ThemeColor),
            onPressed: () {
              if (_privacyRead) {
                CommonUtils.showToast("submitting...");
              }
            },
            child: const Text(
              '提交申请',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          if (!_privacyRead)
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(245, 245, 245, 0.3),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
            ),
        ],
      ),
    );
  }
}
