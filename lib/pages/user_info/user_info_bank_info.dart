import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:provider/provider.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/config/strings.dart';
import 'package:wg_pro_002/widget/common_widget.dart';
import 'package:app_settings/app_settings.dart';
import 'package:wg_pro_002/provider/user_info_provider.dart';
import 'package:wg_pro_002/widget/custom_progress_bar.dart';
import 'package:wg_pro_002/widget/form/wg_form.dart';
import 'package:wg_pro_002/widget/wg_picker_tool.dart';

class UserInfoBankInfo extends StatefulWidget {
  const UserInfoBankInfo({super.key});

  @override
  _UserInfoBankInfoState createState() => _UserInfoBankInfoState();
}

class _UserInfoBankInfoState extends State<UserInfoBankInfo> with CommonWidget {
  final FocusNode _node1 = FocusNode();
  final FocusNode _node2 = FocusNode();
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 在这里添加你的逻辑
            print("处理一些清理工作或保存数据等");
            // 然后返回到上一个页面
            Navigator.pop(context);
          },
        ),
        title: const Text(
          Strings.AdditionalInfoTitle,
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
                  stops: [0.5, 0.5],
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, top: 80),
              child: Stack(children: <Widget>[
                Positioned(
                    top: 0, // 可以调整这个值来控制文本位置
                    right: -20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Image.asset(
                          "${Config.BASE_APP_ASSETS_PATH}app_logo.png",
                          width: MathUtils.screenWidth * 4 / 9, // 指定图片宽度
                          height: MathUtils.screenWidth * 4 / 9, // 指定图片高度
                          fit: BoxFit.cover, // 保证图片覆盖整个容器区域
                        ),
                      ],
                    )),
              ])),
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
                  _headContainer(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Color.fromRGBO(255, 255, 255, 1)),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            const Gap(10),
                            Container(
                                width: MathUtils.screenWidth * 0.5,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(250, 231, 192, 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        Strings.AdditionalInfoTag,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(201, 33, 42, 1),
                                            fontSize: 15),
                                      ),
                                    ])),
                            _infoSection(userInfoProvider),
                            const Gap(10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // 固定在右下角的按钮
              Positioned(
                bottom: 20, // 距离底部 20 像素
                right: 20, // 距离右侧 20 像素
                child: submitButton(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _infoSection(UserInfoProvider userInfoProvider) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Column(
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(children: <Widget>[
                Text(
                  Strings.BankInfo,
                  style: TextStyle(
                      color: Color.fromRGBO(229, 161, 30, 1), fontSize: 15),
                )
              ])),
          getRowTitle(Strings.BankInfoBankName),
          WgFormSelectCell(
            bgColor: TableRowColor,
            text: userInfoProvider.gender,
            hiddenLine: true,
            hintText: 'plz select',
            // textAlign: TextAlign.right,
            clickCallBack: () async {
              List<CommonListOption> genderOptions =
                  await userInfoProvider.genderOptionsFuture ?? [];
              WgPickerTool.showStringPicker(context,
                  data: genderOptions,
                  title: '请选择',
                  labelKey: 'value', clickCallBack: (selectValue, selectIndex) {
                CommonListOption selectedGenderOption =
                    selectValue as CommonListOption;
                userInfoProvider.setGender(
                    selectedGenderOption.id ?? '', selectedGenderOption.value);
                if (kDebugMode) {
                  print('gender selected:$selectValue,$selectIndex');
                }
              });
            },
          ),
          getDivider(),
          getRowTitle(Strings.BankInfoAccountNo),
          WgFormInputCell(
            bgColor: TableRowColor,
            text: userInfoProvider.userInfo?.firstName ?? '',
            focusNode: _node2,
            hiddenLine: true,
            keyboardType: TextInputType.text,
            inputCompletionCallBack: (value, isSubmitted) {
              userInfoProvider.setFirstName(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _headContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Center(
        child: CustomProgressBar(
          width: MathUtils.screenWidth * 0.3,
          progress: 1, // 50% progress
        ),
      ),
    );
  }

  Widget submitButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: WGColors.ThemeColor),
            onPressed: submitForm,
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colours.white,
            ),
          )
        ]));
  }

  void openAppSettings() {
    AppSettings.openAppSettings();
  }

  void submitForm() {
    Fluttertoast.showToast(msg: "Form is valid");
    // Navigator.of(context)        .push(MaterialPageRoute(builder: (context) => const UserInfoPage2()));
  }
}
