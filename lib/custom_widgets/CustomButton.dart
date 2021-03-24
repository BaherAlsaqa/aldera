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
  bool withOutBackground;
  String fontFamily;

  CustomButton({
    this.color = gray0,
    this.width = 1.0,
    this.height = 52.0,
    this.title = "",
    this.function,
    this.textColorValue = white,
    this.borderColor = buttonColor,
    this.radius = 19.0,
    this.borderWidth = 0.0,
    this.fontSize = 19.0,
    this.withOutBackground = false,
    this.fontFamily = PRIMARY_FONT_REGULAR
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.function,
      child: Container(
        width: widget.width <= 1? widget.width.sw: widget.width.w,
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
            color: widget.withOutBackground? Colors.transparent: widget.color,
            focusColor: widget.withOutBackground? Colors.transparent:widget.color,
            disabledColor:widget.withOutBackground? Colors.transparent: widget.color,
            hoverColor: widget.color,
            elevation: 0,
            highlightElevation: 0,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(widget.radius.w),
                      bottomEnd: Radius.circular(widget.radius.w),
                      bottomStart: Radius.circular(widget.radius.w),
                      topStart: Radius.circular(widget.radius.w)
                    ),
            side: BorderSide(color: widget.withOutBackground? Colors.transparent:
              widget.borderColor, width: widget.borderWidth.w),),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[widget.withOutBackground? Colors.transparent:
                    secondaryColor,
                    widget.withOutBackground? Colors.transparent: primaryColor],
                ),
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(widget.radius.w),
                    bottomEnd: Radius.circular(widget.radius.w),
                    bottomStart: Radius.circular(widget.radius.w),
                    topStart: Radius.circular(widget.radius.w)
                ),
              ),
                width: widget.width <= 1? widget.width.sw: widget.width.w,
                height: widget.height.h,
                alignment: AlignmentDirectional.center,
                padding: EdgeInsetsDirectional.only(
                  start: 5.w, end: 5.w, top: 0.h, bottom: 0.h
                ),
                child: Text(
                    getTranslated(context, widget.title),
                  style: TextStyle(
                    fontSize: widget.fontSize.ssp,
                    fontFamily: widget.fontFamily,
                    color: widget.textColorValue,
                  ),
                )),
            onPressed: widget.function),
      ),
    );
  }
}
