import 'dart:io';

import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/AccountCurvePainter.dart';
import 'package:aldera/custom_widgets/CurvePainter.dart';
import 'package:aldera/custom_widgets/CustomButton.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:aldera/custom_widgets/CustomTextField.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String imageToSave = "";
  File imageFile;
  String chooseLang = 'en';

  TextEditingController userName = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  FocusNode focus3 = FocusNode();
  FocusNode focus4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
        child: SafeArea(
            top: true,
            child: Scaffold(
              backgroundColor: white,
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.transparent,
                      child: CustomPaint(
                        painter: AccountCurvePainter(),
                      ),
                    ),
                    PositionedDirectional(
                        top: 140.h,
                        start: 0.w,
                        end: 0.w,
                        child: accountImage()),
                    PositionedDirectional(
                      top: 250.h,
                      start: 0.w,
                      end: 0.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            'Amjad Owaida',
                            translate: false,
                            textColor: textBlack,
                            primaryFont: PRIMARY_FONT_LIGHT,
                            fontSize: 23,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          CustomText(
                            '00972592611271',
                            translate: false,
                            textColor: textBlack,
                            primaryFont: PRIMARY_FONT_REGULAR,
                            fontSize: 20,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    PositionedDirectional(
                      top: 320.h,
                      start: 37.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            'edit',
                            textColor: textBlack,
                            primaryFont: PRIMARY_FONT_REGULAR,
                            fontSize: 14,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 17.h,
                          ),
                          Container(
                            height: 52.h,
                            width: 301.w,
                            child: CustomTextField('Amjad Owaida', userName, focus1,
                                focus2, FULL_NAME, 'pleaseEnterFullName',
                            translate: false,),
                          ),
                          SizedBox(
                            height: 17.h,
                          ),
                          CustomText(
                            'changeAppLangauge',
                            textColor: textBlack,
                            primaryFont: PRIMARY_FONT_REGULAR,
                            fontSize: 14,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                width: 49.w,
                                height: 44.h,
                                color: gray0,
                                title: 'AR',
                                fontSize: 16,
                                translate: false,
                                radius: 12,
                                borderColor: gray0,
                                textColorValue:
                                    chooseLang == 'ar' ? textWhite : titleBlack,
                                differentColor:
                                    chooseLang == 'ar' ? false : true,
                                function: () {
                                  setState(() {
                                    chooseLang = 'ar';
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              CustomButton(
                                width: 49.w,
                                height: 44.h,
                                title: 'EN',
                                fontSize: 16,
                                translate: false,
                                radius: 12,
                                borderColor: gray0,
                                textColorValue:
                                    chooseLang == 'en' ? textWhite : titleBlack,
                                differentColor:
                                    chooseLang == 'en' ? false : true,
                                function: () {
                                  setState(() {
                                    chooseLang = 'en';
                                  });
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: 26.h,
                          ),
                          CustomText(
                            'changePassword',
                            textColor: textBlack,
                            primaryFont: PRIMARY_FONT_REGULAR,
                            fontSize: 14,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          Container(
                            width: 301.w,
                            height: 52.h,
                            child: CustomTextField(
                                "oldPassword",
                                password,
                                focus2,
                                focus3,
                                PASSWORD,
                                "pleaseEnterOldPassword"),
                          ),
                          SizedBox(height: 16.h,),
                          Container(
                            width: 301.w,
                            height: 52.h,
                            child: CustomTextField(
                                "password",
                                password,
                                focus3,
                                focus4,
                                PASSWORD,
                                "pleaseEnterPassword"),
                          ),
                          SizedBox(height: 16.h,),
                          Container(
                            width: 301.w,
                            height: 52.h,
                            child: CustomTextField(
                                "rePassword",
                                rePassword,
                                focus4,
                                focus4,
                                PASSWORD,
                                "pleaseEnterRePassword"),
                          ),
                          SizedBox(height: 16.h,),
                          CustomButton(
                            width: 310.w,
                            height: 52.h,
                            title: 'confirm',
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  Widget accountImage() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        InkWell(
          onTap: () {
            _showPhotoLibrary();
          },
          child: SizedBox(
            width: 97.w,
            height: 97.w,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.sp),
                    boxShadow: [
                      BoxShadow(
                        color: blackShadowColor.withOpacity(0.24),
                        blurRadius: 15.0.sp, // soften the shadow
                        spreadRadius: 0.0.sp, //extend the shadow
                        offset: Offset(
                          0.0.sp, // Move to right 10  horizontally
                          11.0.sp, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: imageToSave == ""
                        ? NetworkImage(
                            'https://www.niemanlab.org/images/Greg-Emerson-edit-2.jpg')
                        : FileImage(File(imageToSave)),
                    radius: 140.w,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _showPhotoLibrary();
          },
          child: Container(
              width: 23.w,
              height: 23.w,
              margin: EdgeInsetsDirectional.only(start: 85.w, bottom: 10.h),
              padding: EdgeInsetsDirectional.only(
                  start: 5.w, end: 5.w, top: 0.h, bottom: 0.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.sp),
                border: Border.all(color: white, width: 1.w),
                color: secondaryColor,
              ),
              child: SvgPicture.asset(ASSETS_NAME_HOME + 'cam.svg')),
        )
      ],
    );
  }

  void _showPhotoLibrary() {
    getImageCrop().then((_imageFile) async {
      print("getImageCrop");
      setState(() {
        imageToSave = _imageFile.path;
        imageFile = _imageFile;
      });
    });
  }
}
