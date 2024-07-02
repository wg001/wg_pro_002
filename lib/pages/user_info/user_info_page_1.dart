import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/app/model/UserInfoForm.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/dao/dao_result.dart';
import 'package:wg_pro_002/dao/user_dao.dart';
import 'package:wg_pro_002/pages/user_info/user_info_page_2.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';
import 'package:wg_pro_002/widget/custom_dropdown.dart';
import 'package:wg_pro_002/widget/input_widget.dart';

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

  Future<void> _loadUserData() async {
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

  EdgeInsets edgeInsets = EdgeInsets.only(left: 8, right: 8, top: 5);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (userInfo == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text("Failed to load user information")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('User Information Page1'),
        backgroundColor: Colors.orange,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  height: MathUtils.screenHeight,
                  decoration: BoxDecoration(color: Colors.orange),
                  child: Column(
                    children: <Widget>[
                      headLable(),
                      Container(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            buildTableRow("ID No.", idController,
                                "Please enter your ID number"),
                            Padding(
                                padding: edgeInsets,
                                child: GenericDropdown<CommonListOption>(
                                  decoration: getDecoration('Gender'),
                                  items: userInfo?.options?.genderOptions,
                                  getDisplayValue: (CommonListOption item) =>
                                      item.value ?? '',
                                  getValue: (CommonListOption item) =>
                                      item.id ?? '',
                                  onChanged: (selectedId) {
                                    setState(() {
                                      genderId = selectedId;
                                    });
                                    print("Selected User ID: $selectedId");
                                  },
                                  selectedValue: getDropListItemByValue(
                                      userInfo?.options?.genderOptions,
                                      userInfo?.gender ??
                                          ''), // Optional: initially select "Bob"
                                )),
                            buildTableRow("ID No.", idController,
                                "Please enter your ID number"),
                            buildTableRow("ID No.", idController,
                                "Please enter your ID number"),
                            buildTableRow("ID No.", idController,
                                "Please enter your ID number"),
                            ElevatedButton(
                              onPressed: _submitForm,
                              child: Text("Submit"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget headLable() {
    return SizedBox(
      height: 50, // 预留足够空间让Card重叠
      child: Card(
        color: Colors.orange,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        elevation: 0,
        child: ListTile(
          title: Text("Base info"),
        ),
      ),
    );
  }

  Widget buildTableRow(
      String label, TextEditingController controller, String emptyError) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: 8, top: 5, right: 8, bottom: 5),
      padding: EdgeInsets.only(left: 8, top: 5, right: 8, bottom: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 241, 241, 241),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: controller,
                style: TextStyle(
                  fontSize: 16, // 控制字体大小
                ),

                textAlign: TextAlign.right, // 右对齐
                cursorHeight: 20, // 设置光标的高度
                decoration: InputDecoration(
                  hintText: 'Please input',
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.3), // 设置提示文字的颜色和透明度
                  ),
                  errorStyle: TextStyle(height: 0),
                  isDense: true, // 减少内部垂直填充
                  contentPadding: EdgeInsets.symmetric(vertical: 1), // 垂直居中
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // 如果表单验证通过
      Fluttertoast.showToast(msg: "Form is valid");
      // 使用Flutter标准的导航方法
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => UserInfoPage2(),
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
}
