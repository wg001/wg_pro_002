import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:provider/provider.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/config/colors.dart';
import 'package:wg_pro_002/config/config.dart';
import 'package:wg_pro_002/config/strings.dart';
import 'package:wg_pro_002/widget/common_widget.dart';
import 'package:wg_pro_002/pages/user_info/user_info_additional.dart';
import 'package:app_settings/app_settings.dart';
import 'package:wg_pro_002/provider/camera_provider.dart';
import 'package:wg_pro_002/provider/user_info_provider.dart';
import 'package:wg_pro_002/utils/common_utils.dart';
import 'package:wg_pro_002/utils/image_utils.dart';
import 'package:wg_pro_002/widget/address_selector.dart';
import 'package:wg_pro_002/widget/camera_preview_widget.dart';
import 'package:wg_pro_002/widget/form/wg_form.dart';
import 'package:wg_pro_002/widget/wg_picker_tool.dart';

const double paddingNum = 10;

class UserInfoPage1 extends StatefulWidget {
  const UserInfoPage1({super.key});

  @override
  _UserInfoPage1State createState() => _UserInfoPage1State();
}

class _UserInfoPage1State extends State<UserInfoPage1> with CommonWidget {
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
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // 点击空白区域隐藏键盘
        child: Scaffold(
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
              Strings.IdentityPageTitle,
              style: TextStyle(color: Colours.white),
            ),
            iconTheme:
                const IconThemeData(color: Colors.white), // 设置图标主题，包括回退按钮颜色
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
              _body(),
            ],
          ),
        ));
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
                        _infoSection01(context, userInfoProvider),
                        const Gap(10),
                        _infoSection02(context, userInfoProvider),
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

  Widget _infoSection01(
      BuildContext context, UserInfoProvider userInfoProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        children: <Widget>[
          getRowTitle("ID NO."),
          WgFormInputCell(
            bgColor: TableRowColor,
            text: "",
            focusNode: _node1,
            keyboardType: TextInputType.number,
            inputCallBack: (value) => {print("hahdhhd----")},
            inputCompletionCallBack: (value, isSubmitted) {
              userInfoProvider.setIdNo(value);
            },
          ),
          getRowTitle("姓名."),
          WgFormInputCell(
            bgColor: TableRowColor,
            text: userInfoProvider.userInfo?.firstName ?? '',
            focusNode: _node2,
            keyboardType: TextInputType.text,
            inputCompletionCallBack: (value, isSubmitted) {
              userInfoProvider.setFirstName(value);
            },
          ),
          getRowTitle(Strings.IdentityImageFront),
          _imageIdentityFront(context, userInfoProvider, null),
          getDivider(),
          getRowTitle(Strings.IdentityImageSelf),
          _imageIdentityFront(context, userInfoProvider, null),
          getDivider(),
        ],
      ),
    );
  }

  Widget _infoSection02(
      BuildContext context, UserInfoProvider userInfoProvider) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      child: Column(
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(children: <Widget>[
                Text(
                  Strings.IdentityAdditionalInfo,
                  style: TextStyle(
                      color: Color.fromRGBO(229, 161, 30, 1), fontSize: 15),
                )
              ])),
          getRowTitle(Strings.IdentityAdditionalInfoEdutionDegree),
          WgFormSelectCell(
            bgColor: TableRowColor,
            text: userInfoProvider.gender,
            hintText: 'plz select',
            // textAlign: TextAlign.right,
            clickCallBack: () async {
              List<CommonListOption> genderOptions =
                  await userInfoProvider.genderOptionsFuture ?? [];
              WgPickerTool.showStringPicker(context,
                  data: genderOptions,
                  title: '请选择类型',
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
          getRowTitle(Strings.IdentityAdditionalInfoJob),
          WgFormSelectCell(
            bgColor: TableRowColor,
            text: userInfoProvider.maritalStatus,
            hintText: 'plz select your marital status',
            // textAlign: TextAlign.right,
            clickCallBack: () async {
              List<CommonListOption> maritalStatusOptions =
                  await userInfoProvider.maritalStatusOptionsFuture ?? [];
              // ignore: use_build_context_synchronously
              WgPickerTool.showStringPicker(context,
                  data: maritalStatusOptions,
                  title: '请选择类型',
                  labelKey: 'value', clickCallBack: (selectValue, selectIndex) {
                CommonListOption selectedGenderOption =
                    selectValue as CommonListOption;
                userInfoProvider.setMaritalStatus(
                    selectedGenderOption.id ?? '', selectedGenderOption.value);
                if (kDebugMode) {
                  print('gender selected:$selectValue,$selectIndex');
                }
              });
            },
          ),
          getRowTitle(Strings.IdentityAdditionalInfoAddress),
          WgFormSelectCell(
            bgColor: TableRowColor,
            text: userInfoProvider.maritalStatus,
            hintText: 'plz select your marital status',
            // textAlign: TextAlign.right,
            clickCallBack: () async {
              List<CommonListOption> maritalStatusOptions =
                  await userInfoProvider.maritalStatusOptionsFuture ?? [];
              // ignore: use_build_context_synchronously
              WgPickerTool.showStringPicker(context,
                  data: maritalStatusOptions,
                  title: '请选择类型',
                  labelKey: 'value', clickCallBack: (selectValue, selectIndex) {
                CommonListOption selectedGenderOption =
                    selectValue as CommonListOption;
                userInfoProvider.setMaritalStatus(
                    selectedGenderOption.id ?? '', selectedGenderOption.value);
                if (kDebugMode) {
                  print('gender selected:$selectValue,$selectIndex');
                }
              });
            },
          ),
          getRowTitle(Strings.IdentityAdditionalInfoAddressDetail),
          WgFormSelectCell(
            bgColor: TableRowColor,
            text: userInfoProvider.maritalStatus,
            hintText: 'plz select your marital status',
            // textAlign: TextAlign.right,
            clickCallBack: () async {
              List<CommonListOption> maritalStatusOptions =
                  await userInfoProvider.maritalStatusOptionsFuture ?? [];
              // ignore: use_build_context_synchronously
              WgPickerTool.showStringPicker(context,
                  data: maritalStatusOptions,
                  title: '请选择类型',
                  labelKey: 'value', clickCallBack: (selectValue, selectIndex) {
                CommonListOption selectedGenderOption =
                    selectValue as CommonListOption;
                userInfoProvider.setMaritalStatus(
                    selectedGenderOption.id ?? '', selectedGenderOption.value);
                if (kDebugMode) {
                  print('gender selected:$selectValue,$selectIndex');
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _headContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 90, // 指定一个高度，以便更明显地看到居中效果
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 255, 241, 0.9),
              Color.fromRGBO(234, 218, 200, 0.9),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Align(
          alignment: Alignment.center, // 使用Align确保内容完全居中
          child: RichText(
            textAlign: TextAlign.center, // 设置文本居中
            text: const TextSpan(children: <InlineSpan>[
              TextSpan(
                text: Strings.IdentityPageHeadDesc1,
                style: TextStyle(
                  // 这里定义文本的样式
                  color: Color.fromRGBO(51, 51, 51, 0.97), // 文本颜色
                  fontSize: 17, // 文本大小
                  fontWeight: FontWeight.bold, // 字体粗细
                ),
              ),
              TextSpan(
                text: "\n",
                style: TextStyle(
                  // 这里定义文本的样式
                  color: Color.fromRGBO(51, 51, 51, 0.97), // 文本颜色
                  fontSize: 17, // 文本大小
                  fontWeight: FontWeight.bold, // 字体粗细
                ),
              ),
              TextSpan(
                text: Strings.IdentityPageHeadDesc2,
                style: TextStyle(
                  // 这里定义文本的样式
                  color: Color.fromRGBO(51, 51, 51, 0.97), // 文本颜色
                  fontSize: 13, // 文本大小
                  fontWeight: FontWeight.normal, // 字体粗细
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Padding selectInputWithBottom(
      String labelText, TextEditingController controller, Function func,
      {double leftPadding = 0.0, double rightPadding = 0.0}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingNum),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: controller,
            readOnly: true, // 设置输入框为只读
            decoration: InputDecoration(
              labelText: labelText,
              hintText: "please select",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Colors.orange.withOpacity(0.5), width: 1.0),
              ),
            ),
            onTap: () => func(), // 点击输入框时调用方法
          ),
        ],
      ),
    );
  }

  SizedBox handleAddressSelect01() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingNum),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Selector<UserInfoProvider, String>(
                  builder: (_, fullAddress, __) => TextFormField(
                    readOnly: true, // 设置输入框为只读
                    controller: TextEditingController(text: fullAddress),
                    decoration: InputDecoration(
                      labelText: "Address",
                      hintText: "Tap to select an address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.5), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.orange.withOpacity(0.5), width: 1.0),
                      ),
                    ),
                    onTap: () => showAddressBottomSheet(context), // 点击输入框时调用方法
                  ),
                  selector: (_, provider) => provider.fullAddress ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showAddressBottomSheet(BuildContext context) {
    // 直接使用 Provider.of 来获取 UserInfoProvider 的实例
    // 我们这里不使用 Selector，因为我们不需要响应任何数据的变化，仅需要调用方法
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return AddressSelector(
          fetchAddress: userInfoProvider.fetchProvince,
          onComplete: (province, city, area) {
            userInfoProvider.updateAddress(province, city, area);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  InputDecoration getDecoration(String label) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 2, top: 10, bottom: 10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), // 设置圆角大小
        borderSide:
            BorderSide(color: Colors.orange.withOpacity(0.5), width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), // 设置圆角大小
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.0),
      ),
      labelText: label,
    );
  }

  dynamic getDropListItemByValue(List<dynamic>? list, String val) {
    if (list == null) {
      return null;
    }
    for (var item in list) {
      if (item.value == val) {
        return item;
      }
    }
    return null;
  }

  Widget _imageIdentityFront(BuildContext context,
      UserInfoProvider userInfoProvider, ImageProvider? imageProvider) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                final cameraManager =
                    Provider.of<CameraProvider>(context, listen: false);
                if (!cameraManager.isInitialized) {
                  await cameraManager.initCamera(CameraLensDirection.back);
                }
                CommonUtils.showCustomDialog(
                  title: "身份证正面照",
                  context: context,
                  content: Column(
                    children: <Widget>[
                      SizedBox(
                        width: MathUtils.screenWidth,
                        height: MathUtils.screenWidth * 0.5,
                        child: Image.asset(
                            '${Config.BASE_APP_ASSETS_PATH}id_front_image_demo.png'),
                      ),
                      const Gap(10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "· 请上传身份证正面照片",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "· 身份证上的信息清晰可见",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                            )
                          ],
                        ),
                      ),
                      // 更多自定义的Widget
                    ],
                  ),
                  onClose: () {
                    Navigator.of(context).pop();
                  },
                  onContinue: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          body: CameraPreviewWidget(
                            onImageCaptured: (path) {
                              Provider.of<UserInfoProvider>(context,
                                      listen: false)
                                  .setImagePath(0, path);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            overlayWidget: Padding(
                                padding: EdgeInsets.zero,
                                child: SizedBox(
                                  width: MathUtils
                                      .screenWidth, // 假设MathUtils.screenWidth是获取屏幕宽度的正确方法
                                  height: MathUtils.screenHeight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Transform.translate(
                                        offset: const Offset(0, -30),
                                        child: Image.asset(
                                            '${Config.BASE_APP_ASSETS_PATH}self_camera_cover.png'),
                                      ),
                                    ],
                                  ),
                                )),
                            initialCameraDirection: CameraLensDirection.front,
                            // preferredOrientations: const [
                            //   DeviceOrientation.landscapeLeft,
                            //   DeviceOrientation.landscapeRight,
                            // ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: (MediaQuery.of(context).size.width) / 2,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(243, 243, 243, 1),
                  image: userInfoProvider.localUploadIdCardSuccess
                      ? DecorationImage(
                          image: NetworkImage(userInfoProvider.idCardImg!),
                          fit: BoxFit.contain,
                          onError: (error, stackTrace) =>
                              const Icon(Icons.error),
                        )
                      : (imageProvider != null
                          ? DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            )
                          : const DecorationImage(
                              image: AssetImage(
                                  '${Config.BASE_APP_ASSETS_PATH}default_image.png'))),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              // if (userInfoProvider.isUploading01)
              //   const CircularProgressIndicator(), // 显示加载指示器
            )
          ],
        ));
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

  void handleCameraPermissionDenied(PlatformException e) {
    if (e.code == 'camera_access_denied') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Camera Permission'),
            content: const Text(
                'Camera permission was denied. Please enable camera access in your settings.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Open Settings'),
                onPressed: () {
                  // Open the app settings.
                  openAppSettings();
                },
              ),
            ],
          );
        },
      );
    } else {
      // 处理其他类型的 PlatformException
      print('Unhandled Platform Exception: ${e.code}');
    }
  }

  void openAppSettings() {
    AppSettings.openAppSettings();
  }

  void submitForm() {
    Fluttertoast.showToast(msg: "Form is valid");
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const UserInfoAdditional()));
  }
}
