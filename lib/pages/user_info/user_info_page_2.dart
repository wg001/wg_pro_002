// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:wg_pro_002/pages/user_info/user_info_sign.dart';
// import 'package:wg_pro_002/widget/form/wg_form_input_cell.dart';
// import 'package:wg_pro_002/widget/form/wg_form_select_cell.dart';
// import 'package:wg_pro_002/widget/wg_button.dart';
// import 'package:wg_pro_002/widget/wg_picker_tool.dart';

// class UserInfoPage2 extends StatefulWidget {
//   static const String sName = "userInfoPage2";

//   const UserInfoPage2({super.key});

//   @override
//   _UserInfoPage2State createState() => _UserInfoPage2State();
// }

// class _UserInfoPage2State extends State<UserInfoPage2> {
//   late TextEditingController idController;
//   late TextEditingController firstController;
//   final _formKey = GlobalKey<FormState>();

//   final dictArr = [
//     {'label': '类型一', 'value': '1'},
//     {'label': '类型二', 'value': '2'},
//     {'label': '类型三', 'value': '3'},
//     {'label': '类型4', 'value': '3'},
//     {'label': '类型5', 'value': '3'},
//     {'label': '类型5', 'value': '3'},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     idController = TextEditingController();
//     firstController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     idController.dispose();
//     firstController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('User Information Page2')),
//       body: _body(),
//     );
//   }

//   _body() {
//     return ListView(
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
//           width: double.infinity,
//           child: const Text(
//             '公司信息',
//             style: TextStyle(
//               fontSize: 20.0, // 字体大小为20
//               fontWeight: FontWeight.bold, // 字体粗体
//             ),
//           ),
//         ),
//         WgFormInputCell(
//           title: '公司名称',
//           text: "",
//           hintText: '请输入手机号(11位)',
//           showRedStar: true,
//           keyboardType: TextInputType.phone,
//           inputCallBack: (value) => {print("hahdhhd----")},
//           inputCompletionCallBack: (value, isSubmitted) {
//             print('inputCompletionCallBack: $value / $isSubmitted ');
//           },
//         ),
//         WgFormInputCell(
//           title: '公司地址',
//           text: "",
//           hintText: '请输入手机号(11位)',
//           showRedStar: true,
//           keyboardType: TextInputType.phone,
//           inputCallBack: (value) => {print("hahdhhd----")},
//           inputCompletionCallBack: (value, isSubmitted) {
//             print('company address : $value / $isSubmitted ');
//           },
//         ),
//         WgFormInputCell(
//           title: '公司月收入',
//           text: "",
//           hintText: '请输入手机号(11位)',
//           showRedStar: true,
//           keyboardType: TextInputType.phone,
//           inputCallBack: (value) => {print("hahdhhd----")},
//           inputCompletionCallBack: (value, isSubmitted) {
//             print('company address : $value / $isSubmitted ');
//           },
//         ),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
//           width: double.infinity,
//           child: const Text(
//             '紧急联系人',
//             style: TextStyle(
//               fontSize: 20.0, // 字体大小为20
//               fontWeight: FontWeight.bold, // 字体粗体
//             ),
//           ),
//         ),
//         WgFormInputCell(
//           title: '公司名称',
//           text: "",
//           hintText: '请输入手机号(11位)',
//           showRedStar: true,
//           keyboardType: TextInputType.phone,
//           inputCallBack: (value) => {print("hahdhhd----")},
//           inputCompletionCallBack: (value, isSubmitted) {
//             print('inputCompletionCallBack: $value / $isSubmitted ');
//           },
//         ),
//         WgFormInputCell(
//           title: '公司地址',
//           text: "",
//           hintText: '请输入手机号(11位)',
//           showRedStar: true,
//           keyboardType: TextInputType.phone,
//           inputCallBack: (value) => {print("hahdhhd----")},
//           inputCompletionCallBack: (value, isSubmitted) {
//             print('company address : $value / $isSubmitted ');
//           },
//         ),
//         WgFormSelectCell(
//           title: '类型',
//           text: '',
//           hintText: '请选择类型',
//           // textAlign: TextAlign.right,
//           clickCallBack: () {
//             WgPickerTool.showStringPicker(context,
//                 data: dictArr,
//                 title: '请选择类型',
//                 labelKey: 'label',
//                 selectIndex: 2, clickCallBack: (selectValue, selectIndex) {
//               if (kDebugMode) {
//                 print('kasdjfklasjdkf$selectValue,$selectIndex');
//               }
//             });
//           },
//         ),
//         const Gap(20),
//         WgButton(
//             text: '下一步',
//             onPressed: () => {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const UserInfoSign()))
//                 })
//       ],
//     );
//   }
// }
