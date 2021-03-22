import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/CircleCurvePainter.dart';
import 'package:aldera/custom_widgets/CustomAppBar.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    systemChrome(darkMode: false);
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: white,
          appBar: CustomAppBar(
            white,
            appBarHeight: 0.0,
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(0.w, -180.h),
                      child: Container(
                        margin: EdgeInsetsDirectional.only(
                          start: 0.w, end: 80.w, top: 0.h, bottom: 0.h
                        ),
                        width: 300.w,
                        height: 300.w,
                        child: CustomPaint(
                          painter: CircleCurvePainter(),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      start: 70.w,
                      top: 50.h,
                      child: Column(
                        children: [
                          SvgPicture.asset(ASSETS_NAME_ICONS + "logo.svg", width: 35.w,),
                          CustomText(
                            'app_name',
                            textColor: textWhite,
                            primaryFont: PRIMARY_FONT_KHEBRAT_MUSAMEM,
                            fontSize: 27,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
