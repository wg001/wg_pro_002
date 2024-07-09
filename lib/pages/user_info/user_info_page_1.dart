import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:wg_pro_002/app/model/AddressSelect.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/app/model/UserInfoForm.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/dao/address_dao.dart';
import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/dao/user_dao.dart';
import 'package:wg_pro_002/pages/user_info/user_info_page_2.dart';
import 'package:app_settings/app_settings.dart';
import 'package:wg_pro_002/widget/custom_dropdown.dart';

const double paddingNum = 10;

class UserInfoPage1 extends StatefulWidget {
  const UserInfoPage1({super.key});

  @override
  _UserInfoPage1State createState() => _UserInfoPage1State();
}

class _UserInfoPage1State extends State<UserInfoPage1>
    with AutomaticKeepAliveClientMixin<UserInfoPage1> {
  @override
  bool get wantKeepAlive => true;
  late TextEditingController idController;
  late TextEditingController firstController;
  TextEditingController? genderIdController;
  TextEditingController? idTypeController;

  UserInfo? userInfo;
  bool isLoading = true;

  List<AddressSelect>? provinces;

  FocusNode idNo = FocusNode();
  FocusNode firstName = FocusNode();
  Uint8List? _image1Data;
  Uint8List? _image2Data;

  late FocusNode dropdownFocusNode;

  String? genderId; //
  String? province;

  bool _isPickingImage = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    firstController = TextEditingController();
    genderIdController = TextEditingController();
    idTypeController = TextEditingController();
    _loadUserData();
    dropdownFocusNode = FocusNode();
    dropdownFocusNode.addListener(_onFocusChange);
  }

  Future<void> getImage(bool isFirstImage, ImageSource source) async {
    if (_isPickingImage) {
      return; // 如果当前正在进行另一个图片选择操作，则直接返回
    }
    _isPickingImage = true; // 设置正在进行图片选择的标志

    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        Uint8List imageData = await pickedFile.readAsBytes();
        setState(() {
          if (isFirstImage) {
            _image1Data = imageData;
          } else {
            _image2Data = imageData;
          }
        });
      }
    } catch (e) {
      // 处理异常
      if (e is PlatformException) {
        _handleCameraPermissionDenied(e);
      } else {
        // 其他类型的错误处理
        print('Error: ${e.toString()}');
      }
    } finally {
      _isPickingImage = false;
    }
  }

  Future<void> _loadUserData() async {
    DataResult res = await UserDao.getUserInfo();
    if (res.result && res.data is UserInfo) {
      setState(() {
        userInfo = res.data as UserInfo;
        idController.text = userInfo?.idNo ?? '';
        firstController.text = userInfo?.firstName ?? '';
        idTypeController?.text = userInfo?.idType ?? '';
        isLoading = false;
      });
    } else {
      Fluttertoast.showToast(msg: "Failed to load user data");
    }
  }

  Future<void> _loadProvice() async {
    if (provinces == null) {
      print("Loading provinces...");
      DataResult provincesData = await AddressDao.getAddressById();
      if (mounted) {
        setState(() {
          provinces = provincesData.data as List<AddressSelect>;
          if (dropdownFocusNode.hasFocus) {
            // 确保下拉菜单在数据加载后仍然聚焦
            dropdownFocusNode.requestFocus();
          }
        });
      } else {
        // 可以在这里处理数据加载失败的情况
        print("Failed to load provinces data");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    idNo.dispose();
    firstName.dispose();
    genderIdController?.dispose();
    idTypeController?.dispose();
    dropdownFocusNode.removeListener(_onFocusChange);
    dropdownFocusNode.dispose();
  }

  void _onFocusChange() {
    if (dropdownFocusNode.hasFocus) {
      // 此处调用加载数据的方法，比如加载省份数据
      print("Dropdown menu opened");
      _loadProvice();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isLoading
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
        child: Column(
          children: [
            const SizedBox(height: 10),
            textField('ID NO.', idController,
                idNo), // Ensure these widgets do not have a fixed height that could cause overflow
            const SizedBox(height: 10),
            textField('First Name', firstController, firstName),
            const SizedBox(height: 10),
            imageContainer(),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2),
                  child: genderSelect(
                      leftPadding: paddingNum, rightPadding: paddingNum / 2),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width) * 0.5,
                  child: genderSelect(
                      rightPadding: paddingNum, leftPadding: paddingNum / 2),
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width) / 2,
                  child: _handleAddressSelect(
                      leftPadding: paddingNum, rightPadding: 5),
                ),
                // SizedBox(
                //   width: (MediaQuery.of(context).size.width * 0.95 - 25) / 3,
                //   child: genderSelect(),
                // ),
              ],
            ),
            Gap(10),
            maritalStatus()
          ],
        ),
      ),
    );
  }

  Padding maritalStatus() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Colors.orange.withOpacity(0.5), width: 1.0),
          ),
          label: GestureDetector(
            onTap: () => {print('aksdfasdf')},
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'asdf',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding genderSelect({double leftPadding = 0.0, double rightPadding = 0.0}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
      child: GenericDropdown<CommonListOption>(
        decoration: getDecoration('Gender'),
        items: userInfo?.options?.genderOptions,
        getDisplayValue: (CommonListOption item) => item.value ?? '',
        getValue: (CommonListOption item) => item.id ?? '',
        onChanged: (selectedId) {
          setState(() {
            genderId = selectedId;
          });
          print("Selected User ID: $selectedId");
        },
        selectedValue: getDropListItemByValue(
            userInfo?.options?.genderOptions, userInfo?.gender ?? ''),
      ),
    );
  }

  Padding _handleAddressSelect(
      {double leftPadding = 0.0, double rightPadding = 0.0}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
      child: GenericDropdown<AddressSelect>(
        decoration: getDecoration('Province'),
        items: provinces,
        getDisplayValue: (AddressSelect item) => item.Value ?? '',
        getValue: (AddressSelect item) => item.Value ?? '',
        onChanged: (selectedId) {
          setState(() {
            province = selectedId;
          });
        },
        selectedValue:
            AddressSelect(Id: '', Value: userInfo?.presentProvince ?? ''),
        focusNode: dropdownFocusNode, // 确保这里是正确引用 _loadProvice
      ),
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
                  child: CustomPaint(
                    painter: LineWithCirclesPainter(),
                  ),
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

  Widget textField(
      String label, TextEditingController controller, FocusNode focuseNode) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingNum),
        child: TextField(
          keyboardType: TextInputType.text,
          focusNode: focuseNode,
          controller: controller,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            labelText: label,
            labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Colors.orange.withOpacity(0.5), width: 1.0)),
          ),
        ));
  }

  Widget imageContainer() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingNum),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            imageWidget(
                _image1Data,
                () => getImage(
                    true, kIsWeb ? ImageSource.gallery : ImageSource.camera),
                "Tap to select image 1"),
            imageWidget(
                _image2Data,
                () => getImage(
                    false, kIsWeb ? ImageSource.gallery : ImageSource.camera),
                "Tap to select image 2"),
          ],
        ));
  }

  Widget imageWidget(
      Uint8List? imageData, VoidCallback onTap, String placeholder) {
    return Center(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.of(context).size.width - 30) / 2,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          image: imageData != null
              ? DecorationImage(
                  image: MemoryImage(imageData), fit: BoxFit.cover)
              : null,
          border: Border.all(color: Colors.grey[300]!, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: imageData == null
            ? Icon(Icons.camera_alt, color: Colors.grey[700])
            : null,
      ),
    ));
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
    if (_formKey.currentState?.validate() ?? false) {
      Fluttertoast.showToast(msg: "Form is valid");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const UserInfoPage2()));
    } else {
      Fluttertoast.showToast(msg: "Please correct the errors in the form.");
    }
  }
}

class LineWithCirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 线条画笔
    final linePaint = Paint()
      ..color = const Color.fromARGB(255, 221, 221, 221)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // 圆的画笔
    final circlePaintBig = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final circlePaintSmall = Paint()
      ..color = const Color.fromARGB(255, 221, 221, 221)
      ..style = PaintingStyle.fill;

    // 文字样式
    // 文字样式
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
      decorationColor: Colors.white,
      decorationStyle: TextDecorationStyle.dotted,
    );
    const textStyleNormal = TextStyle(
      color: Colors.grey,
      fontSize: 12,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
      decorationColor: Colors.grey,
      decorationStyle: TextDecorationStyle.dotted,
    );

    // 计算位置
    final double midY = size.height / 2;
    final double thirdWidth = size.width / 2;

    // 圆的位置
    final Offset firstCirclePos = Offset(0, midY);
    final Offset secondCirclePos = Offset(thirdWidth, midY);
    final Offset thirdCirclePos = Offset(2 * thirdWidth, midY);
    // 画线
    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), linePaint);
    // 画圆
    canvas.drawCircle(firstCirclePos, 11, circlePaintBig);
    canvas.drawCircle(secondCirclePos, 10, circlePaintSmall);
    canvas.drawCircle(thirdCirclePos, 10, circlePaintSmall);

    // 连接圆的线

    // 绘制文字
    drawText(
        canvas, "First", firstCirclePos + const Offset(-20, 20), textStyle);
    drawText(canvas, "Second", secondCirclePos + const Offset(-20, 20),
        textStyleNormal);
    drawText(canvas, "Third", thirdCirclePos + const Offset(-20, 20),
        textStyleNormal);
  }

  void drawText(Canvas canvas, String text, Offset position, TextStyle style) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
