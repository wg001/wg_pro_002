import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:provider/provider.dart';
import 'package:wg_pro_002/app/model/Home.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/config/strings.dart';
import 'package:wg_pro_002/widget/common_widget.dart';
import 'package:app_settings/app_settings.dart';
import 'package:wg_pro_002/pages/user_info/user_info_bank_info.dart';
import 'package:wg_pro_002/provider/camera_provider.dart';
import 'package:wg_pro_002/provider/user_info_provider.dart';
import 'package:wg_pro_002/utils/common_utils.dart';
import 'package:wg_pro_002/utils/image_utils.dart';
import 'package:wg_pro_002/widget/address_selector.dart';
import 'package:wg_pro_002/widget/camera_preview_widget.dart';
import 'package:wg_pro_002/widget/custom_progress_bar.dart';
import 'package:wg_pro_002/widget/form/wg_form.dart';
import 'package:wg_pro_002/widget/wg_picker_tool.dart';

const double paddingNum = 10;

class UserInfoAdditional extends StatefulWidget {
  const UserInfoAdditional({super.key});

  @override
  _UserInfoAdditionalState createState() => _UserInfoAdditionalState();
}

class _UserInfoAdditionalState extends State<UserInfoAdditional>
    with CommonWidget {
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

  Future<void> _takePicture(int imageIndex) async {
    try {
      var userProvider = Provider.of<UserInfoProvider>(context, listen: false);
      await userProvider
          .ensureCameraInitialized(true); // Initialize camera when needed
      await userProvider.takeAndUploadPicture(imageIndex: imageIndex);
    } catch (e) {
      // 处理异常
      if (e is PlatformException) {
        // _handleCameraPermissionDenied(e);
      } else {
        // 其他类型的错误处理
        print('Error: ${e.toString()}');
      }
    }
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
                    Colors.white // 渐变到白色
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _headContainer(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(249, 249, 249, 1),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        _infoSection01(userInfoProvider),
                        const Gap(10),
                        _infoSection02(userInfoProvider),
                        const Gap(10),
                        _infoSection03(userInfoProvider),
                        const Gap(10),
                        // Expanded widget is not suitable here as we are inside a SingleChildScrollView
                        submitButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _infoSection01(UserInfoProvider userInfoProvider) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      child: Column(
        children: <Widget>[
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
                          color: Color.fromRGBO(201, 33, 42, 1), fontSize: 15),
                    ),
                  ])),
          getRowTitle(Strings.AdditionalInfoMonthlyIncome),
          WgFormSelectCell(
            bgColor: TableRowColor,
            hiddenLine: true,
            text: userInfoProvider.gender,
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
          getRowTitle(Strings.AdditionalInfoPayday),
          WgFormInputCell(
            bgColor: TableRowColor,
            hiddenLine: true,
            text: userInfoProvider.userInfo?.firstName ?? '',
            focusNode: _node2,
            keyboardType: TextInputType.text,
            inputCompletionCallBack: (value, isSubmitted) {
              userInfoProvider.setFirstName(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _infoSection02(UserInfoProvider userInfoProvider) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(children: <Widget>[
                Text(
                  Strings.AdditionalInfoEmergencyContact01,
                  style: TextStyle(
                      color: Color.fromRGBO(229, 161, 30, 1), fontSize: 15),
                )
              ])),
          getRowTitle(Strings.AdditionalInfoEmergencyContact01Relationship),
          WgFormSelectCell(
            bgColor: TableRowColor,
            hiddenLine: true,
            text: userInfoProvider.gender,
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
          getRowTitle(Strings.AdditionalInfoEmergencyContact01Name),
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
          getDivider(),
          getRowTitle(Strings.AdditionalInfoEmergencyContact01Phone),
          WgFormInputCell(
            bgColor: TableRowColor,
            hiddenLine: true,
            text: userInfoProvider.userInfo?.firstName ?? '',
            focusNode: _node2,
            keyboardType: TextInputType.text,
            inputCompletionCallBack: (value, isSubmitted) {
              userInfoProvider.setFirstName(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _infoSection03(UserInfoProvider userInfoProvider) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(children: <Widget>[
                Text(
                  Strings.AdditionalInfoEmergencyContact02,
                  style: TextStyle(
                      color: Color.fromRGBO(229, 161, 30, 1), fontSize: 15),
                )
              ])),
          getRowTitle(Strings.AdditionalInfoEmergencyContact02Relationship),
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
          getRowTitle(Strings.AdditionalInfoEmergencyContact02Name),
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
          getDivider(),
          getRowTitle(Strings.AdditionalInfoEmergencyContact02Phone),
          WgFormInputCell(
            bgColor: TableRowColor,
            hiddenLine: true,
            text: userInfoProvider.userInfo?.firstName ?? '',
            focusNode: _node2,
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
          progress: 0.5, // 50% progress
        ),
      ),
    );
  }

  Widget imageChooseWidget(Uint8List? imageData, VoidCallback onTap,
      String placeholder, bool isUploading) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 30) / 2,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              image: imageData != null
                  ? DecorationImage(
                      image: MemoryImage(imageData), fit: BoxFit.cover)
                  : null,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          if (isUploading) const CircularProgressIndicator(), // 显示加载指示器
        ],
      ),
    );
  }

  Widget pictureTakeWidget(int imageIndex, BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          final cameraManager =
              Provider.of<CameraProvider>(context, listen: false);
          if (!cameraManager.isInitialized) {
            await cameraManager.initCamera(CameraLensDirection.back);
          }
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(title: const Text("Camera Preview")),
                body: CameraPreviewWidget(
                  onImageCaptured: (path) {
                    Provider.of<UserInfoProvider>(context, listen: false)
                        .setImagePath(imageIndex, path);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          );
        },
        child: buildImageStack(context, imageIndex),
      ),
    );
  }

  Widget buildImageStack(BuildContext context, int imageIndex) {
    return Consumer<UserInfoProvider>(
      builder: (context, provider, child) {
        var imagePath =
            imageIndex == 0 ? provider.imagePath01 : provider.imagePath02;
        var isUploading =
            imageIndex == 0 ? provider.isUploading01 : provider.isUploading02;

        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: (MediaQuery.of(context).size.width - 30) / 2,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: imagePath != null
                    ? DecorationImage(
                        image: FileImage(File(imagePath)), fit: BoxFit.cover)
                    : null,
                border: Border.all(color: Colors.grey[300]!, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: imagePath == null
                  ? Icon(Icons.camera_alt, color: Colors.grey[700])
                  : null,
            ),
            if (isUploading) const CircularProgressIndicator(),
          ],
        );
      },
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

  void submitForm() {
    Fluttertoast.showToast(msg: "Form is valid");
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const UserInfoBankInfo()));
  }
}
