import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzly_app/src/common/constants/app_colors.dart';
import 'package:quizzly_app/src/common/widgets/language_function.dart';
import 'package:quizzly_app/src/features/components/custom_button.dart';
import 'package:quizzly_app/src/features/screens/quiz_page.dart';

import '../../common/widgets/bottom_quizly_widget.dart';
import '../components/custom_text.dart';
import '../components/quiz_top_widget.dart';
import '../components/confetti.dart';

class ScorePage extends StatefulWidget {
  final int correct;
  final int? second;

  const ScorePage({
    required this.correct,
    this.second,
    super.key,
  });

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  void goHome() {
    Navigator.pop(context);
  }

  void playAgain() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(
          seconds: widget.second,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QuizTop(
            id: false,
            onPressed: goHome,
            score: widget.correct,
          ),
          Positioned(
            top: 289.h,
            left: 36.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 339.w,
                  height: 132.h,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x80000080),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                        vertical: 39.h,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width <= 411
                                ? 120.w
                                : 83,
                            height: 52.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 7.w),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.green,
                                        size: 10.h,
                                      ),
                                    ),
                                    CustomText(
                                      text: '${widget.correct}',
                                      color: Colors.green,
                                      fontSize: 20.sp,
                                    )
                                  ],
                                ),
                                CustomText(
                                  text: languageFunc(context).correct,
                                  color: AppColors.blackTextColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width <= 411
                                ? 120.w
                                : 83,
                            height: 52.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 7.w),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 10.h,
                                      ),
                                    ),
                                    CustomText(
                                      text: '${10 - widget.correct}',
                                      color: Colors.red,
                                      fontSize: 20.sp,
                                    )
                                  ],
                                ),
                                CustomText(
                                  text: languageFunc(context).wrong,
                                  color: AppColors.blackTextColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height < 731 ? 480.h : 550,
            left: 63.w,
            child: SizedBox(
              width: 285.w,
              height: 146.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    text: languageFunc(context).playAgain,
                    onPressed: playAgain,
                    fillColor: Colors.white,
                    borderColor: AppColors.mainColor,
                    textColor: AppColors.blackTextColor,
                  ),
                  CustomButton(
                    text: languageFunc(context).home,
                    onPressed: goHome,
                    fillColor: Colors.white,
                    borderColor: AppColors.mainColor,
                    textColor: AppColors.blackTextColor,
                  )
                ],
              ),
            ),
          ),
          const Bottom(),
          const Confeti(),
        ],
      ),
    );
  }
}
