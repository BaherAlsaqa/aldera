import 'dart:io';

import 'package:aldera/provider/GeneralProvider.dart';
import 'package:aldera/provider/LanguageProvider.dart';
import 'package:aldera/provider/TimerProvider.dart';
import 'package:aldera/screens/splash/SplashScreen.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:aldera/utils/AppLocalization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:aldera/singleton/dio.dart' as dio;

import 'constants/colors.dart';
import 'constants/constants.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dio.init();
  dio.getIt<LanguagesProvider>().fetchLocale();
  systemChrome(darkMode: true, navBarColor: primaryColor,
      navBrightness: Brightness.dark);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => dio.getIt<LanguagesProvider>(),
      ),
      ChangeNotifierProvider(create: (context) => GeneralProvider()),
      ChangeNotifierProvider(create: (context) => TimerProvider()),
    ],
    child: Consumer<LanguagesProvider>(
        builder: (context, languageProvider, child) {
          return ScreenUtilInit(
            designSize: Size(375, 812),
            allowFontScaling: true,
            builder: () => RefreshConfiguration(
                footerTriggerDistance: 15,
                headerTriggerDistance: 80.0,
                dragSpeedRatio: 0.91,
                springDescription:
                SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
                headerBuilder: () => BezierCircleHeader(
                  bezierColor: primaryColor,
                  circleColor: white,
                ),
                footerBuilder: () => CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("");
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("");
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("");
                    } else {
                      body = Text("");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                enableLoadingWhenNoData: false,
                enableLoadingWhenFailed: true,
                shouldFooterFollowWhenNotFull: (state) {
                  return false;
                },
                child: MaterialApp(
                    title: 'Aldera',
                    navigatorKey: navigatorKey,
                    locale: languageProvider.appLocal,
                    theme: ThemeData(
                        primarySwatch: blueColor, fontFamily: PRIMARY_FONT_REGULAR),
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: [
                      AppLocalization.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      DefaultCupertinoLocalizations.delegate
                    ],
                    supportedLocales: [
                      Locale('en'),
                      Locale('ar'),
                    ],
                    localeResolutionCallback: (locale, supportedLocales) {
                      for (var supportedLocale in supportedLocales) {
                        if (supportedLocale.languageCode == locale.languageCode) {
                          return supportedLocale;
                        }
                      }
                      return supportedLocales.first;
                    },
                    home: SplashScreen()),
              ),
          );
        }),
  ));
}
