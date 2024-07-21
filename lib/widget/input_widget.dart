import 'package:flutter/material.dart';

class SelectInputWithBottom extends StatelessWidget {
  final String labelText;
  final String currentValue; // 作为参数传递
  final VoidCallback onTap;
  final double leftPadding;
  final double rightPadding;

  SelectInputWithBottom({
    required this.labelText,
    required this.currentValue,
    required this.onTap,
    this.leftPadding = 0.0,
    this.rightPadding = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: leftPadding + rightPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: TextEditingController(text: currentValue),
            readOnly: true,
            decoration: InputDecoration(
              labelText: labelText,
              hintText: "Please select",
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
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
