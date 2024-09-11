import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double width;
  final double progress;
  final double height;
  Color backgroundColor;
  final Color progressColor;

  CustomProgressBar({
    super.key,
    required this.width,
    required this.progress, // 这个值应该在0.0到1.0之间
    this.height = 10,
    this.backgroundColor = const Color.fromRGBO(229, 221, 200, 1),
    this.progressColor = const Color.fromRGBO(198, 173, 93, 1),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(height / 2), // 圆角大小为高度的一半
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: progress,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: progressColor,
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
        ),
      ),
    );
  }
}
