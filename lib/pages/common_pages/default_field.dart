import 'package:wg_pro_002/common/app_colors.dart';
import 'package:wg_pro_002/common/response_conf.dart';
import 'package:wg_pro_002/common/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';



class DefaultField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  String? labelText;
  bool? isPasswordField;
  IconData? suffixIcon;
  IconData? prefixIcon;

  DefaultField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPasswordField = false, // 默认值为 false
  }) : super(key: key);

  @override
  _DefaultFieldState createState() => _DefaultFieldState();
}

class _DefaultFieldState extends State<DefaultField> {
  late bool isHideCaracter;

  @override
  void initState() {
    super.initState();
    isHideCaracter = widget.isPasswordField!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: TextStyles.bodyMediumMedium.copyWith(color: Pallete.neutral100, fontSize: getFontSize(14)),
          ),
        const Gap(8),
        TextFormField(
          controller: widget.controller,
          obscureText: isHideCaracter,
          obscuringCharacter: '*',
          decoration: _buildInputDecoration(),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      hintText: widget.hintText,
      hintStyle: TextStyles.bodyMediumMedium.copyWith(color: Pallete.neutral60, fontSize: getFontSize(14)),
      contentPadding: EdgeInsets.all(getSize(16)),
      border: _buildOutlineInputBorder(),
      enabledBorder: _buildOutlineInputBorder(),
      focusedBorder: _buildOutlineInputBorder(),
      prefixIcon: widget.prefixIcon != null
          ? Icon(widget.prefixIcon, size: getSize(20), color: const Color(0xFF878787))
          : null,
      suffixIcon: _buildSuffixIcon(),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Pallete.neutral40),
      borderRadius: BorderRadius.circular(getSize(8)),
    );
  }

  Widget _buildSuffixIcon() {
    return widget.isPasswordField == true
        ? InkWell(
            onTap: () => setState(() => isHideCaracter = !isHideCaracter),
            child: Icon(
              isHideCaracter ? Icons.visibility_off : Icons.visibility,
              size: getSize(20),
              color: Pallete.neutral100,
            ),
          )
        : widget.suffixIcon != null
            ? Icon(widget.suffixIcon, size: getSize(20), color: const Color(0xFF878787))
            : SizedBox();
  }
}
