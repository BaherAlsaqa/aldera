import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/utils/language.dart';

class CustomButton extends StatefulWidget {
  Color color;
  double width;
  double height;
  String title;
  Function function;
  Color textColorValue;
  Color borderColor;
  double radius;
  double borderWidth;
  double fontSize;

  CustomButton({
    this.color = buttonColor,
    this.width = 215.0,
    this.height = 54.0,
    this.title = "",
    this.function,
    this.textColorValue = white,
    this.borderColor = buttonColor,
    this.radius = 14.0,
    this.borderWidth = 0.0,
    this.fontSize = 15.0
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width.w,
      height: widget.height.h,
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(
      //       color: shadowColor,
      //       blurRadius: 10.0.sp, // soften the shadow
      //       spreadRadius: 0.0.sp, //extend the shadow
      //       offset: Offset(
      //         0.0.sp, // Move to right 10  horizontally
      //         3.0.sp, // Move to bottom 10 Vertically
      //       ),
      //     )
      //   ],
      // ),
      child: RaisedButton(
          color: widget.color,
          focusColor: widget.color,
          disabledColor: widget.color,
          hoverColor: widget.color,
          elevation: 0,
          highlightElevation: 0,
          shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(widget.radius.w),
                    bottomEnd: Radius.circular(widget.radius.w),
                    bottomStart: Radius.circular(widget.radius.w),
                    topStart: Radius.circular(widget.radius.w)
                  ),
          side: BorderSide(color: widget.borderColor, width: widget.borderWidth.w),),
          child: Container(
              width: widget.width.w,
              height: widget.height.h,
              alignment: AlignmentDirectional.center,
              padding: EdgeInsetsDirectional.only(
                start: 5.w, end: 5.w, top: 0.h, bottom: 0.h
              ),
              child: Text(
                  getTranslated(context, widget.title),
                style: TextStyle(
                  fontSize: widget.fontSize.ssp,
                  fontFamily: PRIMARY_FONT_REGULAR,
                  color: widget.textColorValue,
                ),
              )),
          onPressed: widget.function),
    );
  }
}
