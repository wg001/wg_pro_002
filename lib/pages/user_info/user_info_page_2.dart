import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wg_pro_002/pages/user_info/user_info_page_1.dart';
import 'package:wg_pro_002/utils/navigator_utils.dart';
import 'package:wg_pro_002/widget/custom_form_field.dart';

class UserInfoPage2 extends StatefulWidget {
  static const String sName = "userInfoPage2";

  const UserInfoPage2({super.key});

  @override
  _UserInfoPage2State createState() => _UserInfoPage2State();
}

class _UserInfoPage2State extends State<UserInfoPage2> {
  late TextEditingController idController;
  late TextEditingController firstController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    firstController = TextEditingController();
  }

  @override
  void dispose() {
    idController.dispose();
    firstController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Information Page2')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CustomFormField(
                label: "ID Number",
                controller: idController,
                emptyError: "Please enter your ID number",
              ),
              CustomFormField(
                  label: "First Name",
                  controller: firstController,
                  emptyError: "Please enter your first name"),
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

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      Fluttertoast.showToast(msg: "Form is valid");
      NavigatorUtils.NavigatorRouter(context, UserInfoPage1());
    }
  }
}
