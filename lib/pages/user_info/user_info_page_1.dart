import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/dao/user_dao.dart';
import 'package:wg_pro_002/utils/common_utils.dart';
import 'package:wg_pro_002/widget/custom_dropdown.dart';
import 'package:wg_pro_002/widget/input_widget.dart';

const TextStyle InputStyle = TextStyle(
  color: Colors.grey, // 设置 hintText 的颜色
  fontSize: 16.0,
);

class UserInfoPage1 extends StatefulWidget {
  static const String sName = "userInfoPage1";
  const UserInfoPage1({super.key});

  @override
  _UserInfoPage1State createState() => _UserInfoPage1State();
}

class _UserInfoPage1State extends State<UserInfoPage1>
    with AutomaticKeepAliveClientMixin<UserInfoPage1> {
  @override
  bool get wantKeepAlive => true;

  late UserInfo userInfo;

  late TextEditingController idController;
  late TextEditingController firstController;

  bool isLoading = true; // 添加一个加载状态标志

  final _formKey = GlobalKey<FormState>(); // 创建一个 Form 的 GlobalKey

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    firstController = TextEditingController();
    // 模拟异步加载数据
    _loadUserData();
  }

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    DataResult res = await UserDao.getUserInfo();
    if (res.result && res.data is UserInfo) {
      setState(() {
        UserInfo userInfo = res.data as UserInfo;
        idController.text = userInfo.idNo ?? ''; // 假设 userInfo 有一个 id 字段
        firstController.text = userInfo.firstName ?? '';
        isLoading = false; // 数据加载完成
      });
    }
  }
  // @override
  // Future<void> didChangeDependencies() async {
  //   super.didChangeDependencies();

  //   DataResult res = await UserDao.getUserInfo();
  //   if (res.result && res.data is UserInfo) {
  //     userInfo = res.data as UserInfo;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'HomePage1',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )),
      body: isLoading
          ? CircularProgressIndicator()
          : Form(
              key: _formKey,
              child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildTable(),
                    SubmitButton(),
                  ])),
    );
  }

  Widget buildTable() {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
      border: TableBorder(
        horizontalInside: BorderSide(
          width: 1, // Thickness of the line
          color: Color.fromARGB(255, 255, 255, 255)!
              .withOpacity(0.5), // Color of the line
          style: BorderStyle.solid, // Style of the line
        ),
      ),
      // defaultVerticalAlignment: TableCellVerticalAlignment.,

      children: [
        buildTableRow(
          'ID No.',
          InputWidget(
            hintText: "Enter your ID",
            controller: idController,
            cursorHeight: 20,
            textStyle: TextStyle(height: 1.5),
            errorStyle: TextStyle(
              height: 0, // 减小错误文本的高度影响
              color: Colors.transparent, // 使其透明
            ),
            border: OutlineInputBorder(
              // 设置边框的颜色和宽度
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
              // 设置边框的圆角
              borderRadius: BorderRadius.circular(5.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                // Fluttertoast.showToast(
                //     msg: "Please enter your ID number", // Toast message
                //     toastLength:
                //         Toast.LENGTH_SHORT, // Duration for message display
                //     gravity: ToastGravity.CENTER, // Position of toast message
                //     timeInSecForIosWeb: 1, // Duration in seconds for iOS
                //     backgroundColor:
                //         Colors.red, // Background color for toast message
                //     textColor: Colors.white, // Text color
                //     fontSize: 16.0 // Font size
                //     );
                CommonUtils.showToast('Please enter your ID number');
                return '';
              }
              return null; // 无错误时返回null
            },
          ),
        ),

        buildTableRow(
          'First Name',
          InputWidget(
            hintText: "Enter your First Name",
            controller: firstController,
            cursorHeight: 20,
            textStyle: TextStyle(height: 1.5),
            errorStyle: TextStyle(
              height: 0, // 减小错误文本的高度影响
              color: Colors.transparent, // 使其透明
            ),
            border: OutlineInputBorder(
              // 设置边框的颜色和宽度
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
              // 设置边框的圆角
              borderRadius: BorderRadius.circular(5.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                // Fluttertoast.showToast(
                //     msg: "Please enter your ID number", // Toast message
                //     toastLength:
                //         Toast.LENGTH_SHORT, // Duration for message display
                //     gravity: ToastGravity.CENTER, // Position of toast message
                //     timeInSecForIosWeb: 1, // Duration in seconds for iOS
                //     backgroundColor:
                //         Colors.red, // Background color for toast message
                //     textColor: Colors.white, // Text color
                //     fontSize: 16.0 // Font size
                //     );
                CommonUtils.showToast('Please enter your First Name');
                return '';
              }
              return null; // 无错误时返回null
            },
          ),
        ),

        // buildTableRow('Please Select Gender', CustomDropdown(null,)),
      ],
    );
  }

  TableRow buildTableRow(String leftText, Widget item) {
    return TableRow(
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 8.0, top: 5), // 水平内边距
          alignment: Alignment.centerLeft, // 水平靠左
          child: Text(leftText),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(right: 8.0, top: 5), // 水平内边距
          alignment: Alignment.centerLeft, // 水平靠左
          child: item,
        ),
      ],
    );
  }

  Widget SubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          // 表单验证成功
          print('Form is valid');
        } else {
          // 表单验证失败
          print('Form is not valid');
        }
      },
      child: Text("Submit"),
    );
  }
}
