import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final bool obscureText;
  final String? hintText;
  final IconData? iconData;
  final ValueChanged<String>? onChanged;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final InputBorder? border;
  final double? cursorHeight;
  final InputBorder? focusedBorder;
  final TextStyle? errorStyle;
  final InputBorder? enabledBorder;
  final String? Function(String?)? validator; // 添加验证器函数参数

  const InputWidget({
    Key? key,
    this.hintText,
    this.hintStyle,
    this.iconData,
    this.onChanged,
    this.textStyle,
    this.controller,
    this.obscureText = false,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.errorStyle,
    this.cursorHeight,
    this.validator, // 接收一个验证函数
  }) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      style: widget.textStyle,
      textAlignVertical: TextAlignVertical.bottom,
      cursorHeight: widget.cursorHeight,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorStyle: widget.errorStyle ?? widget.errorStyle,
        hintStyle: widget.hintStyle == null
            ? TextStyle(color: Colors.grey.withOpacity(0.5))
            : widget.hintStyle,
        icon: widget.iconData == null ? null : Icon(widget.iconData),
        border: widget.border ?? OutlineInputBorder(),
        focusedBorder: widget.focusedBorder,
        enabledBorder: widget.enabledBorder,
        errorBorder: widget.enabledBorder,
        focusedErrorBorder: widget.focusedBorder,
      ),
      validator: widget.validator,
    );
  }
}
