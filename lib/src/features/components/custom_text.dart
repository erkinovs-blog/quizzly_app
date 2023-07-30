import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final int? maxLines;
  final String? fontFamily;

  const CustomText({
    required this.text,
    required this.color,
    required this.fontSize,
    this.fontWeight = FontWeight.w500,
    this.maxLines,
    this.fontFamily,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: TextAlign.center,
      overflow: TextOverflow.visible,
      style: TextStyle(
        fontFamily: fontFamily,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
