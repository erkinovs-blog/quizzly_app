import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzly_app/src/common/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;
  final void Function() onPressed;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.fillColor = AppColors.mainColor,
    this.borderColor = Colors.white,
    this.textColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        elevation: 4,
        surfaceTintColor: Colors.purpleAccent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        minimumSize: Size(50.w, 20.h),
        maximumSize: Size(284.w, 57.h),
        // fixedSize: Size(284.w, 57.h),
        backgroundColor: fillColor,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
