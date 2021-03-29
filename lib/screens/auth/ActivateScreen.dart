import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/CircleCurvePainter.dart';
import 'package:aldera/custom_widgets/CustomAppBar.dart';
import 'package:aldera/custom_widgets/CustomButton.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:aldera/custom_widgets/CustomTextField.dart';
import 'package:aldera/provider/LanguageProvider.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'SignUpScreen.dart';

class ActivateScreen extends StatefulWidget {
  @override
  _ActivateScreenState createState() => _ActivateScreenState();
}

class _ActivateScreenState extends State<ActivateScreen> {
  TextEditingController code = TextEditingController();
  FocusNode focus1 = FocusNode();
  final formKey = GlobalKey<FormState>();

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
              alignment: AlignmentDirectional.topEnd,
              children: [
                Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(getIt<LanguagesProvider>().appLocal == Locale('ar')? -110.w: 20.w, -180.h),
                      child: Container(
                        width: 300.w,
                        height: 300.w,
                        child: CustomPaint(
                          painter: CircleCurvePainter(),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      end: getIt<LanguagesProvider>().appLocal == Locale('ar')? 90.w: 60.w,
                      top: 50.h,
                      child: Column(
                        children: [
                          Container(
                              width: 35.w,
                              height: 35.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp),
                                boxShadow: [
                                  BoxShadow(
                                    color: blackShadowColor.withOpacity(0.1),
                                    blurRadius: 11.0.sp, // soften the shadow
                                    spreadRadius: 2.0.sp, //extend the shadow
                                    offset: Offset(
                                      0.0.sp, // Move to right 10  horizontally
                                      3.0.sp, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: SvgPicture.asset(ASSETS_NAME_ICONS + "logo.svg", width: 35.w,)),
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
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 34.w, end: 34.w, top: 242.h.h, bottom: 0.h
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'activate',
                          textColor: titleBlack,
                          primaryFont: PRIMARY_FONT_REGULAR,
                          fontSize: 24,
                        ),
                        SizedBox(height: 6.h,),
                        CustomText(
                          'enterVerificationCodeSentTextMessage',
                          textColor: textBlack,
                          primaryFont: PRIMARY_FONT_LIGHT,
                          fontSize: 17,
                          lines: 3,
                        ),
                        SizedBox(height: 37.h,),
                        CustomTextField(
                          "code",
                          code,
                          focus1,
                          focus1,
                          MOBILE,
                          "pleaseEnterCode",
                        ),
                        SizedBox(height: 17.h,),
                        CustomButton(
                          title: 'confirmButton',
                          function: (){
                            //todo enter code here
                            if(formKey.currentState.validate()){
                              print('loginButton');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
