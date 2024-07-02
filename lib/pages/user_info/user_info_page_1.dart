import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wg_pro_002/app/model/UserInfo.dart';
import 'package:wg_pro_002/app/model/UserInfoForm.dart';
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
      appBar: AppBar(title: Text('User Information Page1')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GenericDropdown<IdTypeOption>(
                          decoration: getDecoration('ID Type'),
                          items: userInfo?.options?.idTypeOptions,
                          getDisplayValue: (IdTypeOption item) =>
                              item.value ?? '',
                          getValue: (IdTypeOption item) => item.id ?? '',
                          onChanged: (selectedId) {
                            setState(() {
                              idType = selectedId;
                            });
                            print("Selected idtype: $selectedId");
                          },
                          selectedValue: getDropListItemByValue(
                              userInfo?.options?.idTypeOptions,
                              idTypeController?.text ??
                                  ''), // Optional: initially select "Bob"
                        )),
                    buildTableRow(
                        "ID No.", idController, "Please enter your ID number"),
                    buildTableRow("First Name", firstController,
                        "Please enter your first name"),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GenericDropdown<CommonListOption>(
                          decoration: getDecoration('Gender'),
                          items: userInfo?.options?.genderOptions,
                          getDisplayValue: (CommonListOption item) =>
                              item.value ?? '',
                          getValue: (CommonListOption item) => item.id ?? '',
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
                    /**  Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child:
                            buildDropdown('Province', 'Please select option 1'),
                      ),
                      SizedBox(width: 8.0), // 可以在中间添加间距
                      Expanded(
                        child: buildDropdown('City', 'Please select option 2'),
                      ),
                      SizedBox(width: 8.0), // 可以在中间添加间距
                      Expanded(
                        child: buildDropdown('Area', 'Please select option 3'),
                      ),
                    ],
                  )),
                  */
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  final List<String> options = ["Option 1", "Option 2", "Option 3"];
  String? selectedOption;
  Widget buildDropdown(
      String label, TextEditingController controller, String emptyError) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.orange.withOpacity(0.5), width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.5), width: 2.0),
          ),
          labelText: label,
        ),
        value: controller.text,
        onChanged: (String? newValue) {
          setState(() {
            selectedOption = newValue;
          });
        },
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            Fluttertoast.showToast(msg: emptyError);
            return emptyError;
          }
          return null;
        },
        isExpanded: true, // 让下拉菜单尽可能填满水平空间
      ),
    );
  }

  Widget buildTableRow(
      String label, TextEditingController controller, String emptyError) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        onChanged: ,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange.withOpacity(0.5), // 聚焦时的颜色
              width: 2.0,
            ),
          ),
          // 启用时的边框
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.5), // 启用时的颜色
              width: 2.0,
            ),
          ),
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            Fluttertoast.showToast(msg: emptyError);
            return emptyError; // Return a space to denote an error but not expand the TextFormField
          }
          return null;
        },
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
