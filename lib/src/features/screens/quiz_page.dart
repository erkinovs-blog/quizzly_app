import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzly_app/src/common/widgets/language_function.dart';
import '../../common/constants/app_colors.dart';
import '../../common/widgets/bottom_quizly_widget.dart';
import '../models/random_data.dart';
import '../components/indicator.dart';
import '../components/quiz_top_widget.dart';
import '../components/custom_button.dart';
import '../components/custom_text.dart';
import 'launch_page.dart';
import 'score_page.dart';

class QuizPage extends StatefulWidget {
  final int? seconds;

  const QuizPage({
    super.key,
    this.seconds,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  ValueNotifier<int> quiz = ValueNotifier(1);
  ValueNotifier<double> indicatorValue = ValueNotifier(50);
  RandomData random = RandomData();
  int correctAnswers = 0;

  Timer? timer;
  late ValueNotifier<double> seconds =
      ValueNotifier(widget.seconds?.toDouble() ?? 0.0);

  bool res = false;

  @override
  void initState() {
    super.initState();
    if (widget.seconds != null) {
      timer = Timer.periodic(
        const Duration(milliseconds: 100),
        (timer) {
          if (seconds.value > 0) {
            seconds.value = seconds.value - 0.1;
          } else {
            if (quiz.value == 10) {
              timer.cancel();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ScorePage(
                    correct: correctAnswers,
                    second: widget.seconds,
                  ),
                ),
              );
            } else {
              random.reset();
              seconds.value = widget.seconds!.toDouble();
              quiz.value++;
            }
          }
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void onPressed(String selected) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LaunchPage(
          selected: ValueNotifier(Locale(selected)),
        ),
      ),
    );
  }

  void onTap(double e) {
    if (random.correctAnswer() == e) {
      correctAnswers++;
    }
    if (quiz.value >= 10) {
      timer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScorePage(
            correct: correctAnswers,
            second: widget.seconds,
          ),
        ),
      );
    } else {
      random.reset();
      seconds.value = widget.seconds?.toDouble() ?? 0;
      quiz.value += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          // Background
          Stack(
            children: [
              QuizTop(
                onPressed: () => Navigator.pop(context),
                score: 0,
              ),
            ],
          ),
          // Quiz SizeBox
          Positioned(
            top: 135.h,
            left: 51.w,
            child: SizedBox(
              width: 309.w,
              height: 170.h,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      // color: Colors.red,
                      color: Color(0xFFFBECFF),
                      spreadRadius: -2,
                      offset: Offset(0, 7.5),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120.w,
                        height: 18.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: languageFunc(context).question,
                              color: AppColors.textColor,
                              fontSize: 14.sp,
                            ),
                            ValueListenableBuilder(
                              valueListenable: quiz,
                              builder: (context, value, child) {
                                return CustomText(
                                  text:
                                      '${value.toString().padLeft(2, '0')}/10',
                                  color: AppColors.textColor,
                                  fontSize: 14.sp,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: random.string,
                        builder: (context, value, child) {
                          return CustomText(
                            text: value,
                            color: AppColors.blackTextColor,
                            fontSize: 16.sp,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Linear Circle
          Positioned(
            left: 172.w,
            top: 100.h,
            child: SizedBox(
              width: 67.w,
              height: 67.h,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: widget.seconds == null
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: const DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image(
                                image: AssetImage(
                                    "assets/images/infinity_symbol.png"),
                                height: 30,
                                width: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : ValueListenableBuilder(
                          valueListenable: seconds,
                          builder: (context, value, child) {
                            return SizedBox(
                              width: MediaQuery.sizeOf(context).width < 310
                                  ? 30
                                  : 45.h,
                              height: 45.h,
                              child: CustomIndicator(
                                value:
                                    (widget.seconds! - value) / widget.seconds!,
                                child: Center(
                                  child: CustomText(
                                    text: "${value.round()}",
                                    color: AppColors.mainColor,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 340.h,
            left: 63.w,
            child: SizedBox(
              width: 285.w,
              height: 303.h,
              child: ValueListenableBuilder(
                valueListenable: random.list,
                builder: (context, value, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: value
                        .map(
                          (e) => CustomButton(
                            text: e.toStringAsFixed(1),
                            onPressed: () => onTap(e),
                            fillColor: Colors.white,
                            borderColor: AppColors.mainColor,
                            textColor: AppColors.blackTextColor,
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          ),
          // Bottom widget
          const Bottom(),
        ],
      ),
    );
  }
}
