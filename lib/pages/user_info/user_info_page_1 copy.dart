// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gap/gap.dart';
// import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
// import 'package:provider/provider.dart';
// import 'package:wg_pro_002/app/model/UserInfo.dart';
// import 'package:wg_pro_002/pages/user_info/user_info_page_2.dart';
// import 'package:app_settings/app_settings.dart';
// import 'package:wg_pro_002/provider/camera_provider.dart';
// import 'package:wg_pro_002/provider/user_info_provider.dart';
// import 'package:wg_pro_002/utils/common_utils.dart';
// import 'package:wg_pro_002/utils/image_utils.dart';
// import 'package:wg_pro_002/widget/address_selector.dart';
// import 'package:wg_pro_002/widget/camera_preview_widget.dart';
// import 'package:wg_pro_002/widget/form/wg_form.dart';
// import 'package:wg_pro_002/widget/form/wg_form_input_cell.dart';
// import 'package:wg_pro_002/widget/form/wg_form_select_cell.dart';
// import 'package:wg_pro_002/widget/input_widget.dart';
// import 'package:intl/intl.dart';
// import 'package:wg_pro_002/widget/wg_picker_tool.dart';

// const double paddingNum = 10;

// class UserInfoPage1 extends StatefulWidget {
//   const UserInfoPage1({super.key});

//   @override
//   _UserInfoPage1State createState() => _UserInfoPage1State();
// }

// class _UserInfoPage1State extends State<UserInfoPage1> {
//   final FocusNode _node1 = FocusNode();
//   final FocusNode _node2 = FocusNode();
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         Provider.of<UserInfoProvider>(context, listen: false).loadUserData();
//       }
//     });
//   }

//   Future<void> _takePicture(int imageIndex) async {
//     try {
//       var userProvider = Provider.of<UserInfoProvider>(context, listen: false);
//       await userProvider
//           .ensureCameraInitialized(true); // Initialize camera when needed
//       await userProvider.takeAndUploadPicture(imageIndex: imageIndex);
//     } catch (e) {
//       // 处理异常
//       if (e is PlatformException) {
//         _handleCameraPermissionDenied(e);
//       } else {
//         // 其他类型的错误处理
//         print('Error: ${e.toString()}');
//       }
//     }
//   }

//   @override
//   void dispose() {
//     print("page 1 disposed");
//     _node1.dispose();
//     _node2.dispose();
//     super.dispose(); // 确保父类的 dispose 方法被调用
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserInfoProvider>(
//       builder: (BuildContext context, userInfoProvider, Widget? child) {
//         if (userInfoProvider.isLoading) {
//           // Display loading screen when data is being fetched
//           return Scaffold(
//             appBar: AppBar(title: const Text('User Information Page 1')),
//             body: const Center(child: CircularProgressIndicator()),
//           );
//         } else {
//           // Display user information page when data is loaded
//           return GestureDetector(
//             onTap: () {
//               // Dismiss the keyboard when the user taps anywhere on the screen outside input fields
//               FocusScope.of(context).unfocus();
//             },
//             child: Scaffold(
//               appBar: AppBar(title: const Text('User Information Page 1')),
//               body: KeyboardActions(
//                 config: WgKeyboardUtils.getKeyboardConfig(
//                     context, [_node1, _node2]),
//                 child: SafeArea(child: _body(userInfoProvider)),
//               ),
//               // body: SafeArea(child: _body(userInfoProvider)),
//             ),
//           );
//         }
//       },
//     );
//   }

//   Widget _body(UserInfoProvider userInfoProvider) {
//     return SingleChildScrollView(
//         child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.white,
//             ),
//             width: MediaQuery.of(context).size.width * 1,
//             padding: const EdgeInsets.all(0), // Appropriate padding
//             child: Column(children: [
//               WgFormInputCell(
//                 title: 'ID No.',
//                 text: userInfoProvider.idNo,
//                 hintText: 'plz input your ID No.',
//                 focusNode: _node1,
//                 showRedStar: true,
//                 keyboardType: TextInputType.number,
//                 inputCallBack: (value) => {print("hahdhhd----")},
//                 inputCompletionCallBack: (value, isSubmitted) {
//                   userInfoProvider.setIdNo(value);
//                 },
//               ),
//               WgFormInputCell(
//                 title: 'First Name',
//                 text: userInfoProvider.userInfo?.firstName ?? '',
//                 hintText: 'plz input your first name',
//                 showRedStar: true,
//                 focusNode: _node2,
//                 keyboardType: TextInputType.text,
//                 inputCallBack: (value) => {print("hahdhhd----")},
//                 inputCompletionCallBack: (value, isSubmitted) {
//                   userInfoProvider.setFirstName(value);
//                 },
//               ),
//               WgFormInputCell(
//                 title: 'Last Name',
//                 text: userInfoProvider.lastName,
//                 hintText: 'plz input your last name',
//                 showRedStar: true,
//                 keyboardType: TextInputType.text,
//                 inputCallBack: (value) => {print("hahdhhd----")},
//                 inputCompletionCallBack: (value, isSubmitted) {
//                   userInfoProvider.setLastName(value);
//                 },
//               ),
//               WgFormInputCell(
//                 title: 'middle Name',
//                 text: userInfoProvider.middleName,
//                 hintText: 'plz input your Middle name',
//                 showRedStar: true,
//                 keyboardType: TextInputType.text,
//                 // inputCallBack: (value) => {print("hgogogog----")},
//                 inputCompletionCallBack: (value, isSubmitted) {
//                   print('===>$value');
//                   userInfoProvider.setMiddleName(value);
//                 },
//               ),

//               WgFormSelectCell(
//                 title: 'gender',
//                 text: userInfoProvider.gender,
//                 hintText: 'plz select your gender',
//                 // textAlign: TextAlign.right,
//                 showRedStar: true,
//                 clickCallBack: () async {
//                   List<CommonListOption> genderOptions =
//                       await userInfoProvider.genderOptionsFuture ?? [];
//                   WgPickerTool.showStringPicker(context,
//                       data: genderOptions, title: '请选择类型', labelKey: 'value',
//                       clickCallBack: (selectValue, selectIndex) {
//                     CommonListOption selectedGenderOption =
//                         selectValue as CommonListOption;
//                     userInfoProvider.setGender(selectedGenderOption.id ?? '',
//                         selectedGenderOption.value);
//                     if (kDebugMode) {
//                       print('gender selected:$selectValue,$selectIndex');
//                     }
//                   });
//                 },
//               ),
//               WgFormSelectCell(
//                 title: 'Marital Status',
//                 text: userInfoProvider.maritalStatus,
//                 showRedStar: true,
//                 hintText: 'plz select your marital status',
//                 // textAlign: TextAlign.right,
//                 clickCallBack: () async {
//                   List<CommonListOption> maritalStatusOptions =
//                       await userInfoProvider.maritalStatusOptionsFuture ?? [];
//                   // ignore: use_build_context_synchronously
//                   WgPickerTool.showStringPicker(context,
//                       data: maritalStatusOptions,
//                       title: '请选择类型',
//                       labelKey: 'value',
//                       clickCallBack: (selectValue, selectIndex) {
//                     CommonListOption selectedGenderOption =
//                         selectValue as CommonListOption;
//                     userInfoProvider.setMaritalStatus(
//                         selectedGenderOption.id ?? '',
//                         selectedGenderOption.value);
//                     if (kDebugMode) {
//                       print('gender selected:$selectValue,$selectIndex');
//                     }
//                   });
//                 },
//               ),
//               // const SizedBox(height: 10),
//               // imageContainer(),

//               imageContainer(),
//               const Gap(10),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: SelectInputWithBottom(
//                   labelText: 'Educational Degress',
//                   currentValue: userInfoProvider.educationDegree,
//                   onTap: () => CommonUtils.showCommonListOptionBottomSheet(
//                       context,
//                       'Please Education Degress',
//                       userInfoProvider.edutionDegreeOptionsFuture!,
//                       (String id, String value) {
//                     userInfoProvider.setEducationDegree(id, value);
//                   }, align: Alignment.center),
//                   sizePadding: paddingNum,
//                 ),
//               ),
//               const Gap(10),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: SelectInputWithBottom(
//                   labelText: 'Birthday',
//                   currentValue: userInfoProvider.birthday,
//                   onTap: () => {
//                     CommonUtils.showDatePicker(context, (date) {
//                       String confirmedBirthday =
//                           DateFormat('yyyy-MM-dd').format(date);
//                       print(">>>>$confirmedBirthday");
//                       userInfoProvider.setBirthday(confirmedBirthday);
//                     })
//                   },
//                   sizePadding: paddingNum,
//                 ),
//               ),
//               const Gap(10),
//               maritalStatus(),
//               const Gap(10),
//               _handleAddressSelect01(),
//               const Gap(10),
//               submitButton()
//             ])));
//   }

//   Padding maritalStatus() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: TextField(
//         keyboardType: TextInputType.text,
//         decoration: CommonUtils.getInputDecoration(
//           label: 'Marital Status',
//         ),
//       ),
//     );
//   }

//   Padding selectInputWithBottom(
//       String labelText, TextEditingController controller, Function func,
//       {double leftPadding = 0.0, double rightPadding = 0.0}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: paddingNum),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           TextFormField(
//             controller: controller,
//             readOnly: true, // 设置输入框为只读
//             decoration: InputDecoration(
//               labelText: labelText,
//               hintText: "please select",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide:
//                     BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.0),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(
//                     color: Colors.orange.withOpacity(0.5), width: 1.0),
//               ),
//             ),
//             onTap: () => func(), // 点击输入框时调用方法
//           ),
//         ],
//       ),
//     );
//   }

//   SizedBox _handleAddressSelect01() {
//     return SizedBox(
//       width: double.infinity,
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: paddingNum),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Selector<UserInfoProvider, String>(
//                   builder: (_, fullAddress, __) => TextFormField(
//                     readOnly: true, // 设置输入框为只读
//                     controller: TextEditingController(text: fullAddress),
//                     decoration: InputDecoration(
//                       labelText: "Address",
//                       hintText: "Tap to select an address",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 10),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                             color: Colors.grey.withOpacity(0.5), width: 1.0),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                             color: Colors.orange.withOpacity(0.5), width: 1.0),
//                       ),
//                     ),
//                     onTap: () => _showAddressBottomSheet(context), // 点击输入框时调用方法
//                   ),
//                   selector: (_, provider) => provider.fullAddress ?? '',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddressBottomSheet(BuildContext context) {
//     // 直接使用 Provider.of 来获取 UserInfoProvider 的实例
//     // 我们这里不使用 Selector，因为我们不需要响应任何数据的变化，仅需要调用方法
//     var userInfoProvider =
//         Provider.of<UserInfoProvider>(context, listen: false);

//     showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         return AddressSelector(
//           fetchAddress: userInfoProvider.fetchProvince,
//           onComplete: (province, city, area) {
//             userInfoProvider.updateAddress(province, city, area);
//             Navigator.pop(context);
//           },
//         );
//       },
//     );
//   }

//   InputDecoration getDecoration(String label) {
//     return InputDecoration(
//       contentPadding: const EdgeInsets.only(left: 2, top: 10, bottom: 10),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10), // 设置圆角大小
//         borderSide:
//             BorderSide(color: Colors.orange.withOpacity(0.5), width: 1.0),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10), // 设置圆角大小
//         borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.0),
//       ),
//       labelText: label,
//     );
//   }

//   dynamic getDropListItemByValue(List<dynamic>? list, String val) {
//     if (list == null) {
//       return null;
//     }
//     for (var item in list) {
//       if (item.value == val) {
//         return item;
//       }
//     }
//     return null;
//   }

//   Column background_container(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 240,
//           decoration: const BoxDecoration(
//             color: Colors.orange,
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             ),
//           ),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: const Icon(Icons.arrow_back, color: Colors.white),
//                     ),
//                     const Text(
//                       'Personal Info',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white),
//                     ),
//                     const SizedBox()
//                   ],
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(top: 0), // Remove vertical padding
//                 child: SizedBox(
//                   width: 300,
//                   height: 60,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Widget userInfoDetails() {
//   //   return Column(
//   //     children: [
//   //       textField("ID NO.", idController),
//   //       textField("First Name", firstController),
//   //     ],
//   //   );
//   // }

//   Padding InputWidget({
//     required String label,
//     required String initialValue,
//     required void Function(String) onChanged,
//     required BuildContext context,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: TextField(
//         onChanged: onChanged,
//         controller: TextEditingController(text: initialValue)
//           ..selection = TextSelection.collapsed(offset: initialValue.length),
//         keyboardType: TextInputType.text,
//         decoration: CommonUtils.getInputDecoration(
//           label: label,
//         ),
//       ),
//     );
//   }

//   Widget imageContainer() {
//     return Consumer<UserInfoProvider>(
//         builder: (BuildContext context, userInfoProvider, Widget? child) {
//       ImageProvider? idcardBackgroundImage;
//       ImageProvider? idcardHandBackgroundImage;
//       if (kIsWeb) {
//         if (userInfoProvider.imageWeb02 != null) {
//           idcardBackgroundImage = MemoryImage(userInfoProvider.imageWeb02!);
//         }
//         if (userInfoProvider.imageWeb01 != null) {
//           idcardBackgroundImage = MemoryImage(userInfoProvider.imageWeb01!);
//         }
//       } else {
//         if (userInfoProvider.imagePath01 != null &&
//             File(userInfoProvider.imagePath01!).existsSync()) {
//           idcardBackgroundImage =
//               FileImage(File(userInfoProvider.imagePath01!));
//         }
//         if (userInfoProvider.imagePath02 != null &&
//             File(userInfoProvider.imagePath02!).existsSync()) {
//           idcardHandBackgroundImage =
//               FileImage(File(userInfoProvider.imagePath02!));
//         }
//       }
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: paddingNum),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GestureDetector(
//               onTap: () async {
//                 if (kIsWeb) {
//                   var result = await ImageUtils.pickImageWeb();
//                   if (result['error'] != null) {
//                   } else {
//                     userInfoProvider.setIdCardWebImage(
//                         result['imageData'], result['extension']);
//                   }
//                 } else {
//                   print("0000000");
//                   final cameraManager =
//                       Provider.of<CameraProvider>(context, listen: false);
//                   if (!cameraManager.isInitialized) {
//                     await cameraManager.initCamera(CameraLensDirection.back);
//                   }
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => Scaffold(
//                         appBar: AppBar(title: const Text("Camera Preview")),
//                         body: CameraPreviewWidget(
//                           onImageCaptured: (path) {
//                             Provider.of<UserInfoProvider>(context,
//                                     listen: false)
//                                 .setImagePath(0, path);
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ),
//                     ),
//                   );
//                   // _takePicture(0);
//                 }
//               },
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: (MediaQuery.of(context).size.width - 30) / 2,
//                     height: 80,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       image: userInfoProvider.localUploadIdCardSuccess == false
//                           ? DecorationImage(
//                               image: NetworkImage(userInfoProvider.idCardImg!),
//                               fit: BoxFit.contain,
//                               onError: (error, stackTrace) =>
//                                   const Icon(Icons.error),
//                             )
//                           : (idcardBackgroundImage != null
//                               ? DecorationImage(
//                                   image: idcardBackgroundImage,
//                                   fit: BoxFit.contain,
//                                 )
//                               : null),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   if (userInfoProvider.isUploading01)
//                     const CircularProgressIndicator(), // 显示加载指示器
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () async {
//                 if (kIsWeb) {
//                   var result = await ImageUtils.pickImageWeb();
//                   if (result['error'] != null) {
//                   } else {
//                     userInfoProvider.setHandIdCardWebImage(
//                         result['imageData'], result['extension']);
//                   }
//                 } else {
//                   // _takePicture(1);
//                   print("1111111");
//                   final cameraManager =
//                       Provider.of<CameraProvider>(context, listen: false);
//                   if (!cameraManager.isInitialized) {
//                     await cameraManager.initCamera(CameraLensDirection.back);
//                   }
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => Scaffold(
//                         appBar: AppBar(title: const Text("Camera Preview")),
//                         body: CameraPreviewWidget(
//                           onImageCaptured: (path) {
//                             Provider.of<UserInfoProvider>(context,
//                                     listen: false)
//                                 .setImagePath(1, path);
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ),
//                     ),
//                   );
//                   // _takePicture(0);
//                 }
//               },
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: (MediaQuery.of(context).size.width - 30) / 2,
//                     height: 80,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       image: userInfoProvider.localUploadIdCardSuccess == false
//                           ? DecorationImage(
//                               image:
//                                   NetworkImage(userInfoProvider.idCardHandImg!),
//                               fit: BoxFit.contain,
//                               onError: (error, stackTrace) =>
//                                   const Icon(Icons.error),
//                             )
//                           : (idcardHandBackgroundImage != null
//                               ? DecorationImage(
//                                   image: idcardHandBackgroundImage,
//                                   fit: BoxFit.contain,
//                                 )
//                               : null),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   if (userInfoProvider.isUploading02)
//                     const CircularProgressIndicator(), // 显示加载指示器
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   // Widget imageContainer() {
//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(horizontal: paddingNum),
//   //     child: Row(
//   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //       children: [
//   //         // 使用三元运算符来选择显示哪个 Widget
//   //         userInfoProvider.idCardImg != null
//   //             ? GestureDetector(
//   //                 onTap: () {
//   //                  imageChooseWidget(
//   //                     userInfoProvider.imageWeb01,
//   //                     () => getImage(true, ImageSource.gallery),
//   //                     "Tap to select image 1",
//   //                     userInfoProvider.isUploading01);
//   //                 },
//   //                 child: Image.network(
//   //                   width: (MediaQuery.of(context).size.width - 30) / 2,
//   //                   height: 80,
//   //                   userInfoProvider.idCardImg!,
//   //                   errorBuilder: (context, error, stackTrace) =>
//   //                       Icon(Icons.error),
//   //                   loadingBuilder: (context, child, loadingProgress) {
//   //                     if (loadingProgress == null) return child;
//   //                     return Center(child: CircularProgressIndicator());
//   //                   },
//   //                 ))
//   //             : (kIsWeb
//   //                 ? imageChooseWidget(
//   //                     userInfoProvider.imageWeb01,
//   //                     () => getImage(true, ImageSource.gallery),
//   //                     "Tap to select image 1",
//   //                     userInfoProvider.isUploading01)
//   //                 : pictureTakeWidget(0, context)),

//   //         // 这里假设无论在 Web 还是移动环境都可使用相同逻辑
//   //         kIsWeb
//   //             ? imageChooseWidget(
//   //                 userInfoProvider.imageWeb02,
//   //                 () => getImage(false, ImageSource.gallery),
//   //                 "Tap to select image 2",
//   //                 userInfoProvider.isUploading02)
//   //             : pictureTakeWidget(1, context),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // Widget imageChooseWidget(
//   //     Uint8List? imageData, VoidCallback onTap, String placeholder) {
//   //   return Center(
//   //       child: GestureDetector(
//   //     onTap: onTap,
//   //     child: Container(
//   //       width: (MediaQuery.of(context).size.width - 30) / 2,
//   //       height: 80,
//   //       decoration: BoxDecoration(
//   //         color: Colors.grey[300],
//   //         image: imageData != null
//   //             ? DecorationImage(
//   //                 image: MemoryImage(imageData), fit: BoxFit.cover)
//   //             : null,
//   //         border: Border.all(color: Colors.grey[300]!, width: 2),
//   //         borderRadius: BorderRadius.circular(12),
//   //       ),
//   //       child: imageData == null
//   //           ? Icon(Icons.camera_alt, color: Colors.grey[700])
//   //           : null,
//   //     ),
//   //   ));
//   // }

//   Widget imageChooseWidget(Uint8List? imageData, VoidCallback onTap,
//       String placeholder, bool isUploading) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Container(
//             width: (MediaQuery.of(context).size.width - 30) / 2,
//             height: 80,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               image: imageData != null
//                   ? DecorationImage(
//                       image: MemoryImage(imageData), fit: BoxFit.cover)
//                   : null,
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           if (isUploading) const CircularProgressIndicator(), // 显示加载指示器
//         ],
//       ),
//     );
//   }

//   Widget pictureTakeWidget(int imageIndex, BuildContext context) {
//     return Center(
//       child: GestureDetector(
//         onTap: () async {
//           final cameraManager =
//               Provider.of<CameraProvider>(context, listen: false);
//           if (!cameraManager.isInitialized) {
//             await cameraManager.initCamera(CameraLensDirection.back);
//           }
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => Scaffold(
//                 appBar: AppBar(title: const Text("Camera Preview")),
//                 body: CameraPreviewWidget(
//                   onImageCaptured: (path) {
//                     Provider.of<UserInfoProvider>(context, listen: false)
//                         .setImagePath(imageIndex, path);
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//           );
//         },
//         child: buildImageStack(context, imageIndex),
//       ),
//     );
//   }

//   Widget buildImageStack(BuildContext context, int imageIndex) {
//     return Consumer<UserInfoProvider>(
//       builder: (context, provider, child) {
//         var imagePath =
//             imageIndex == 0 ? provider.imagePath01 : provider.imagePath02;
//         var isUploading =
//             imageIndex == 0 ? provider.isUploading01 : provider.isUploading02;

//         return Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               width: (MediaQuery.of(context).size.width - 30) / 2,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 image: imagePath != null
//                     ? DecorationImage(
//                         image: FileImage(File(imagePath)), fit: BoxFit.cover)
//                     : null,
//                 border: Border.all(color: Colors.grey[300]!, width: 2),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: imagePath == null
//                   ? Icon(Icons.camera_alt, color: Colors.grey[700])
//                   : null,
//             ),
//             if (isUploading) const CircularProgressIndicator(),
//           ],
//         );
//       },
//     );
//   }

//   Widget submitButton() {
//     return ElevatedButton(
//       onPressed: _submitForm,
//       child: const Text('Submit'),
//     );
//   }

//   void _handleCameraPermissionDenied(PlatformException e) {
//     if (e.code == 'camera_access_denied') {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Camera Permission'),
//             content: const Text(
//                 'Camera permission was denied. Please enable camera access in your settings.'),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('Cancel'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                 child: const Text('Open Settings'),
//                 onPressed: () {
//                   // Open the app settings.
//                   openAppSettings();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // 处理其他类型的 PlatformException
//       print('Unhandled Platform Exception: ${e.code}');
//     }
//   }

//   void openAppSettings() {
//     AppSettings.openAppSettings();
//   }

//   void _submitForm() {
//     Fluttertoast.showToast(msg: "Form is valid");
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => const UserInfoPage2()));
//   }
// }
