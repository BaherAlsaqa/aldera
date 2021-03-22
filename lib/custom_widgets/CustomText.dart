import 'package:flutter/material.dart';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/utils/language.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  String text;
  bool translate;
  double fontSize;
  String primaryFont;
  // FontWeight fontWeight;
  Color textColor;
  int lines;
  TextAlign textAlign;
  bool paragraph;
  bool isOffer;

  CustomText(this.text,
      {this.fontSize = 14,
      this.primaryFont = PRIMARY_FONT_REGULAR,
      /*this.fontWeight = FontWeight.normal,*/
      this.textColor = titleColor,
      this.translate = true,
      this.lines = 1,
      this.textAlign = TextAlign.start,
      this.paragraph = false,
      this.isOffer = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      translate? getTranslated(context, text): text,
      textAlign: textAlign,
      maxLines: paragraph? null: lines,
      style: TextStyle(
        decoration: isOffer? TextDecoration.lineThrough: null,
        decorationStyle: TextDecorationStyle.solid,
        decorationColor: textWhite,
        decorationThickness: 30.h,
        fontSize: fontSize-2.ssp,
        fontFamily: primaryFont,
        // fontWeight: fontWeight,
        color: textColor,
      ),
    );
  }
}
