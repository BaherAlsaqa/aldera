import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SelectSectionCell extends StatelessWidget {
  int index;
  Function onSelect;
  SelectSectionCell(this.index, this.onSelect);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        start: 0.w, end: 0.w, top: 0.h, bottom: 13.h
      ),
      padding: EdgeInsetsDirectional.only(
        start: 32.w, end: 32.w, top: 0.h, bottom: 0.h
      ),
      width: 1.0.w,
      height: 67.h,
      alignment: AlignmentDirectional.centerStart,
      decoration: BoxDecoration(
        gradient: index == 0? LinearGradient(
          colors: <Color>[secondaryColor, primaryColor],
        ): null,
        border: Border.all(
          color: borderGray,
          width: 1.w
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12.sp),
          topLeft: Radius.circular(12.sp),
          bottomRight: Radius.circular(12.sp),
          bottomLeft: Radius.circular(12.sp)
       ),
        color: white,
        boxShadow: [
          BoxShadow(
            color: blackShadowColor.withOpacity(0.12),
            blurRadius: 8.0.sp, // soften the shadow
            spreadRadius: 0.0.sp, //extend the shadow
            offset: Offset(
              0.0.sp, // Move to right 10  horizontally
              5.0.sp, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: CustomText(
        'Kuwait News',
        translate: false,
        textColor: index == 0? textWhite: textBlack1,
        primaryFont: PRIMARY_FONT_MEDIUM,
        fontSize: 18,
      ),
    );
  }
}
