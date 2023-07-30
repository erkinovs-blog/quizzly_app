import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzly_app/src/common/widgets/language_function.dart';

import '../../common/constants/app_colors.dart';
import 'custom_text.dart';

class QuizTop extends StatefulWidget {
  final int score;
  final bool id;
  final void Function() onPressed;

  const QuizTop({
    required this.onPressed,
    required this.score,
    this.id = true,
    super.key,
  });

  @override
  State<QuizTop> createState() => _QuizTopState();
}

class _QuizTopState extends State<QuizTop> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.id ? 221.h : 334.h,
      width: double.infinity,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: AppColors.mainColor,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 35.h,
              left: 20.w,
              child: BackButton(
                onPressed: widget.onPressed,
                color: AppColors.whiteColor,
              ),
            ),
            //  1 Circle
            Positioned(
              right: widget.id ? 335.w : 354.w,
              top: widget.id ? 86.h : 69.h,
              child: SizedBox(
                width: 98.w,
                height: 98.h,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.circleColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            // 2 Circle
            Positioned(
              left: widget.id ? 114.w : 94.w,
              bottom: widget.id ? 160.h : 280.h,
              child: SizedBox(
                width: 98.w,
                height: 98.h,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.circleColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            // 3 Circle
            Positioned(
              top: widget.id ? 28.h : 9.h,
              left: widget.id ? 255.w : 240.w,
              child: SizedBox(
                width: 43.w,
                height: 44.h,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.circleColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            // 4 Circle
            Positioned(
              top: widget.id ? 107.h : 90.h,
              left: widget.id ? 333.w : 321.w,
              child: SizedBox(
                width: 98.w,
                height: 98.h,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.circleColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            widget.id
                ? const SizedBox.shrink()
                : Positioned(
                    top: 80.h,
                    left: 118.w,
                    right: 118.w,
                    child: AvatarGlow(
                      endRadius: 100,
                      glowColor: const Color(0x32FFFFFF),
                      duration: const Duration(milliseconds: 2000),
                      repeatPauseDuration: const Duration(milliseconds: 10),
                      child: SizedBox(
                        width: 120.w,
                        height: 120.h,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: languageFunc(context).yourScore,
                                  color: AppColors.mainColor,
                                  fontSize: 18.sp,
                                ),
                                CustomText(
                                  text: '${widget.score * 10}',
                                  color: AppColors.mainDarkColor,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
