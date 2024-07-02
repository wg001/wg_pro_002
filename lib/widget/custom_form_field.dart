import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String emptyError;

  const CustomFormField({
    Key? key,
    required this.label,
    required this.controller,
    required this.emptyError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange.withOpacity(0.5), // 聚焦时的颜色
              width: 2.0,
            ),
          ),
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
}
