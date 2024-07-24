import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/mixins/disposable_mixin.dart';
import 'package:wg_pro_002/pages/user_info/user_info_page_2.dart';
import 'package:app_settings/app_settings.dart';
import 'package:wg_pro_002/provider/camera_provider.dart';
import 'package:wg_pro_002/provider/user_info_provider.dart';
import 'package:wg_pro_002/utils/common_utils.dart';
import 'package:wg_pro_002/utils/image_utils.dart';
import 'package:wg_pro_002/widget/address_selector.dart';
import 'package:wg_pro_002/widget/camera_preview_widget.dart';
import 'package:wg_pro_002/widget/input_widget.dart';
import 'package:intl/intl.dart';

const double paddingNum = 10;

class UserInfoPage1 extends StatefulWidget {
  const UserInfoPage1({super.key});

  @override
  _UserInfoPage1State createState() => _UserInfoPage1State();
}

class _UserInfoPage1State extends State<UserInfoPage1>
    with AutomaticKeepAliveClientMixin<UserInfoPage1>, Disposable {
  @override
  bool get wantKeepAlive => true;

  late UserInfoProvider userProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserInfoProvider>(context, listen: false);
      userProvider.loadUserData();
    });
  }

  // 选择相册
  Future<void> getImage(bool isFirstImage, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        Uint8List imageData = await pickedFile.readAsBytes();
        final extension = ImageUtils.getExtensionFromPath(pickedFile.path);

        isFirstImage
            ? userProvider.setIdCardWebImage(imageData, extension)
            : userProvider.setHandIdCardWebImage(imageData, extension);
      }
    } catch (e) {
      // 处理异常
      if (e is PlatformException) {
        _handleCameraPermissionDenied(e);
      } else {
        // 其他类型的错误处理
        print('Error: ${e.toString()}');
      }
    }
  }

  Future<void> _takePicture(int imageIndex) async {
    try {
      await userProvider
          .ensureCameraInitialized(true); // Initialize camera when needed
      await userProvider.takeAndUploadPicture(imageIndex: imageIndex);
    } catch (e) {
      // 处理异常
      if (e is PlatformException) {
        _handleCameraPermissionDenied(e);
      } else {
        // 其他类型的错误处理
        print('Error: ${e.toString()}');
      }
    }
  }

  @override
  void dispose() {
    disposeResources(); // 调用 mixin 的 disposeResources 方法清理资源
    super.dispose(); // 确保父类的 dispose 方法被调用
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<UserInfoProvider>(
        builder: (BuildContext context, userInfoProvider, Widget? child) {
      return userInfoProvider.isLoading
          ? Scaffold(
              appBar: AppBar(title: const Text('Loading...')),
              body: const Center(child: CircularProgressIndicator()),
            )
          : GestureDetector(
              onTap: () {
                // 当点击非输入字段区域时，关闭键盘
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                body: SafeArea(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: background_container(context),
                      ),
                      Positioned(
                        top: 120, // Adjust this value as needed
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: main_container(),
                      ),
                    ],
                  ),
                ),
              ));
    });
  }

  Widget main_container() {
    return SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width * 1,
            padding: const EdgeInsets.all(0), // Appropriate padding
            child: Column(children: [
              const SizedBox(height: 10),
              InputWidget(
                label: "ID NO",
                initialValue: userProvider.idNo,
                onChanged: (value) => userProvider.setIdNo(value),
                context: context,
              ), // Ensure these widgets do not have a fixed height that could cause overflow
              const SizedBox(height: 10),

              InputWidget(
                label: "First Name1",
                initialValue: userProvider.firstName,
                onChanged: (value) => userProvider.setFirstName(value),
                context: context,
              ),
              const SizedBox(height: 10),
              imageContainer(),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2),
                    child: SelectInputWithBottom(
                      labelText: 'Gender',
                      currentValue: userProvider.gender,
                      onTap: () => CommonUtils.showCommonListOptionBottomSheet(
                          context,
                          'Please Choose Gender',
                          userProvider.genderOptionsFuture!,
                          (String id, String value) {
                        userProvider.setGender(id, value);
                      }, align: Alignment.center),
                      sizePadding: paddingNum,
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2),
                    child: SelectInputWithBottom(
                      labelText: 'Marital Status',
                      currentValue: userProvider.maritalStatus,
                      onTap: () => CommonUtils.showCommonListOptionBottomSheet(
                          context,
                          'Please Choose Marital Status',
                          userProvider.maritalStatusOptionsFuture!,
                          (String id, String value) {
                        userProvider.setMaritalStatus(id, value);
                      }, align: Alignment.center),
                      sizePadding: paddingNum,
                    ),
                  ),
                ],
              ),
              const Gap(10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SelectInputWithBottom(
                  labelText: 'Educational Degress',
                  currentValue: userProvider.educationDegree,
                  onTap: () => CommonUtils.showCommonListOptionBottomSheet(
                      context,
                      'Please Education Degress',
                      userProvider.edutionDegreeOptionsFuture!,
                      (String id, String value) {
                    userProvider.setEducationDegree(id, value);
                  }, align: Alignment.center),
                  sizePadding: paddingNum,
                ),
              ),
              const Gap(10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SelectInputWithBottom(
                  labelText: 'Birthday',
                  currentValue: userProvider.birthday,
                  onTap: () => {
                    CommonUtils.showDatePicker(context, (date) {
                      String confirmedBirthday =
                          DateFormat('yyyy-MM-dd').format(date);
                      print(">>>>$confirmedBirthday");
                      userProvider.setBirthday(confirmedBirthday);
                    })
                  },
                  sizePadding: paddingNum,
                ),
              ),
              const Gap(10),
              maritalStatus(),
              const Gap(10),
              _handleAddressSelect01(),
              const Gap(10),
            ])));
  }

  Padding maritalStatus() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: CommonUtils.getInputDecoration(
          label: 'Marital Status',
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

  SizedBox _handleAddressSelect01() {
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
                    onTap: () => _showAddressBottomSheet(context), // 点击输入框时调用方法
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

  void _showAddressBottomSheet(BuildContext context) {
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

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Text(
                      'Personal Info',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox()
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 0), // Remove vertical padding
                child: SizedBox(
                  width: 300,
                  height: 60,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  // Widget userInfoDetails() {
  //   return Column(
  //     children: [
  //       textField("ID NO.", idController),
  //       textField("First Name", firstController),
  //     ],
  //   );
  // }

  Padding InputWidget({
    required String label,
    required String initialValue,
    required void Function(String) onChanged,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        onChanged: onChanged,
        controller: TextEditingController(text: initialValue)
          ..selection = TextSelection.collapsed(offset: initialValue.length),
        keyboardType: TextInputType.text,
        decoration: CommonUtils.getInputDecoration(
          label: label,
        ),
      ),
    );
  }

  Widget imageContainer() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingNum),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            kIsWeb
                ? imageChooseWidget(
                    userProvider.imageWeb01,
                    () => getImage(true, ImageSource.gallery),
                    "Tap to select image 1",
                    userProvider.isUploading01)
                : pictureTakeWidget(0, context),
            kIsWeb
                ? imageChooseWidget(
                    userProvider.imageWeb02,
                    () => getImage(false, ImageSource.gallery),
                    "Tap to select image 2",
                    userProvider.isUploading02)
                : pictureTakeWidget(1, context),
          ],
        ));
  }

  // Widget imageChooseWidget(
  //     Uint8List? imageData, VoidCallback onTap, String placeholder) {
  //   return Center(
  //       child: GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       width: (MediaQuery.of(context).size.width - 30) / 2,
  //       height: 80,
  //       decoration: BoxDecoration(
  //         color: Colors.grey[300],
  //         image: imageData != null
  //             ? DecorationImage(
  //                 image: MemoryImage(imageData), fit: BoxFit.cover)
  //             : null,
  //         border: Border.all(color: Colors.grey[300]!, width: 2),
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: imageData == null
  //           ? Icon(Icons.camera_alt, color: Colors.grey[700])
  //           : null,
  //     ),
  //   ));
  // }

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
    return ElevatedButton(
      onPressed: _submitForm,
      child: const Text('Submit'),
    );
  }

  void _handleCameraPermissionDenied(PlatformException e) {
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

  void _submitForm() {
    Fluttertoast.showToast(msg: "Form is valid");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const UserInfoPage2()));
  }
}
