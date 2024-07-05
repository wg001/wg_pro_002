import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/app/model/UserInfoForm.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/dao/user_dao.dart';
import 'package:wg_pro_002/pages/user_info/user_info_page_2.dart';
import 'package:wg_pro_002/utils/common_utils.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';
import 'package:wg_pro_002/widget/custom_dropdown.dart';
import 'package:wg_pro_002/widget/input_widget.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';

// 特别为Web导入html库
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

  UserInfoForm userInfoForm = UserInfoForm();

  String? genderId; //
  String? idType; //

  bool isLoading = true; // 添加一个加载状态标志

  FocusNode idNo = FocusNode();

  File? _image1File;
  File? _image2File;

  Uint8List? _image1Data;
  Uint8List? _image2Data;

  final _formKey = GlobalKey<
      FormState>(); // Keep using the form key for overall form validation

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    firstController = TextEditingController();
    genderIdController = TextEditingController();
    idTypeController = TextEditingController();
    _loadUserData();
  }

  // Function to handle image picking
  Future<void> getImage() async {
    if (CommonUtils.isWeb) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // 在 Web 上，使用 readAsBytes() 方法读取文件数据
        Uint8List imageData = await pickedFile.readAsBytes();
        setState(() {
          _image1Data = imageData;
        });
        // html.FileReader reader = html.FileReader();
        // reader.readAsArrayBuffer(pickedFile.file);
        // reader.onLoadEnd.listen((event) {
        //   setState(() {
        //     _imageData = reader.result as Uint8List;
        //   });
        // });
      }
    } else {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image1File = File(pickedFile.path);
        });
      }
    }
  }

  Future<void> getImage2() async {
    if (CommonUtils.isWeb) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // 在 Web 上，使用 readAsBytes() 方法读取文件数据
        Uint8List imageData = await pickedFile.readAsBytes();
        setState(() {
          _image2Data = imageData;
        });
        // html.FileReader reader = html.FileReader();
        // reader.readAsArrayBuffer(pickedFile.file);
        // reader.onLoadEnd.listen((event) {
        //   setState(() {
        //     _imageData = reader.result as Uint8List;
        //   });
        // });
      }
    } else {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image2File = File(pickedFile.path);
        });
      }
    }
  }

  Future<void> _loadUserData() async {
    await Future.delayed(const Duration(seconds: 10));
    DataResult res = await UserDao.getUserInfo();
    if (res.result && res.data is UserInfo) {
      setState(() {
        userInfo = res.data as UserInfo; // 初始化 userInfo
        idController.text = userInfo?.idNo ?? '';
        firstController.text = userInfo?.firstName ?? '';
        idTypeController?.text = userInfo?.idType ?? '';
        isLoading = false;
      });
    } else {
      // 处理加载失败的情况
      Fluttertoast.showToast(msg: "Failed to load user data");
    }
  }

  @override
  void dispose() {
    idController.dispose();
    firstController.dispose();
    super.dispose();
  }

  EdgeInsets edgeInsets = const EdgeInsets.only(left: 8, right: 8, top: 5);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Loading...')),
        body: const SafeArea(child: Center(child: CircularProgressIndicator())),
      );
    }

    if (userInfo == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const SafeArea(
            child: Center(child: Text("Failed to load user information"))),
      );
    }

    return Scaffold(
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
    );
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

  Widget main_container() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width * 0.95,
        padding: const EdgeInsets.all(20), // Appropriate padding
        child: Column(
          children: [
            const SizedBox(height: 10),
            name(), // Ensure these widgets do not have a fixed height that could cause overflow
            const SizedBox(height: 10),
            amount(),
            const SizedBox(height: 10),
            image_container()
          ],
        ),
      ),
    );
  }

  Padding image_container() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: image1(),
          ),
          Expanded(
            child: image2(),
          ),
        ],
      ),
    );
  }

  Widget image1() {
    return Center(
        child: GestureDetector(
      onTap: () => getImage(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          image: _image1File != null
              ? DecorationImage(
                  image: FileImage(_image1File!),
                  fit: BoxFit.cover,
                )
              : _image1Data != null
                  ? DecorationImage(
                      image: MemoryImage(_image1Data!),
                      fit: BoxFit.cover,
                    )
                  : null,
          border: Border.all(color: Colors.grey[300]!, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _image1File == null && _image1Data == null
            ? const Center(
                child: Text("Tap to select image",
                    style: TextStyle(color: Colors.black)))
            : null,
      ),
    ));
  }

  Widget image2() {
    return Center(
        child: GestureDetector(
      onTap: () => getImage2(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          image: _image2File != null
              ? DecorationImage(
                  image: FileImage(_image2File!),
                  fit: BoxFit.cover,
                )
              : _image2Data != null
                  ? DecorationImage(
                      image: MemoryImage(_image2Data!),
                      fit: BoxFit.cover,
                    )
                  : null,
          border: Border.all(color: Colors.grey[300]!, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _image2File == null && _image2Data == null
            ? const Center(
                child: Text("Tap to select image",
                    style: TextStyle(color: Colors.black)))
            : null,
      ),
    ));
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // 如果表单验证通过
      Fluttertoast.showToast(msg: "Form is valid");
      // 使用Flutter标准的导航方法
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const UserInfoPage2(),
      ));
    } else {
      // 如果表单验证不通过，也可以在这里处理
      Fluttertoast.showToast(msg: "Please correct the errors in the form.");
    }
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

  InputDecoration getDecoration(String label) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Colors.orange.withOpacity(0.5), width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 2.0),
      ),
      labelText: label,
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: idNo,
        controller: idController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          labelText: 'ID NO.',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xff368983))),
        ),
      ),
    );
  }

  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: idNo,
        controller: idController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          labelText: 'ID NO.',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xff368983))),
        ),
      ),
    );
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
