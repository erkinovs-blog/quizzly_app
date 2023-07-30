import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/screens/launch_page.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  ValueNotifier<Locale> selected = ValueNotifier(Locale(AppLocalizations.supportedLocales.first.languageCode));

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 731),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              SharedPreferences db = snapshot.data!;
              selected.value = Locale(db.getString("language") ?? AppLocalizations.supportedLocales.first.languageCode);
              return ValueListenableBuilder(
                  valueListenable: selected,
                  builder: (context, value, _) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Quizzly App',
                      theme: ThemeData(
                        useMaterial3: true,
                        fontFamily: "DM Sans"
                      ),
                      home: child,
                      localizationsDelegates: AppLocalizations.localizationsDelegates,
                      supportedLocales: AppLocalizations.supportedLocales,
                      locale: value,
                    );
                  }
              );
            } else {
              return const MaterialApp(
                home: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          }
        );
      },
      child: LaunchPage(selected: selected),
    );
  }
}
