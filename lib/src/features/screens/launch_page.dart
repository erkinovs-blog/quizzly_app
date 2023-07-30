import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzly_app/generated/assets.dart';
import 'package:quizzly_app/src/common/widgets/language_function.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/language.dart';
import 'quiz_page.dart';
import '../components/custom_button.dart';
import '../../common/constants/app_colors.dart';
import '../components/custom_text.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key, required this.selected});
  final ValueNotifier<Locale> selected;

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {


  List<QuizPage> quizes = [
    const QuizPage(seconds: null),
    const QuizPage(seconds: 20),
    const QuizPage(seconds: 10),
  ];

  void navigateToQuiz(int? value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(
          seconds: value,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.mainColor,
            image: DecorationImage(
              opacity: .5,
              image: AssetImage(Assets.imagesImBg),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: FutureBuilder(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        SharedPreferences db = snapshot.data!;
                        return ValueListenableBuilder(
                            valueListenable: widget.selected,
                            builder: (context, value, child) {
                              return DropdownButton<String>(
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    widget.selected.value = Locale(newValue);
                                    db.setString("language", newValue);
                                  }
                                },
                                items: Language.languageList().map(
                                      (e) {
                                    return DropdownMenuItem(
                                      alignment: Alignment.centerLeft,
                                      value: e.languageCode,
                                      onTap: () {},
                                      child: SizedBox(
                                        width: 60.w,
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          dense: true,
                                          minVerticalPadding: 0,
                                          visualDensity: const VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          leading: Text(
                                            e.flag,
                                            style: TextStyle(fontSize: 20.sp),
                                          ),
                                          title: Text(
                                            e.name,
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                value: value.languageCode,
                                iconSize: 10.w,
                                dropdownColor: Colors.black26,
                              );
                            }
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }
                  ),
                ),
                Text(
                  'QUIZZLY',
                  style: TextStyle(
                    fontFamily: "Expletus Sans",
                    fontSize: 67.sp,
                    color: AppColors.whiteColor,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 361.w,
                  height: 203.h,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Color(0x99FFFFFF),
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.normal,
                          color: Color(0x4DFFFFFF),
                          blurRadius: 6,
                          offset: Offset(0, 10),
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: languageFunc(context).helloMessage,
                            color: AppColors.textColor,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            text: languageFunc(context).helloSubtitle,
                            color: AppColors.textColor,
                            fontSize: 22.sp,
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 277.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        text: languageFunc(context).levelTitle,
                        color: AppColors.whiteColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      ...List.generate(
                        3,
                        (index) => CustomButton(
                          text: languageFunc(context).level(index + 1),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => quizes[index],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // color: AppColors.mainColor,
        ),
      ),
    );
  }
}
