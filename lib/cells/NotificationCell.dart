import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NotificationCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        start: 0.w, end: 0.w, top: 0.h, bottom: 17.h
      ),
      padding: EdgeInsetsDirectional.only(
        start: 16.w, end: 16.w, top: 10.h, bottom: 10.h
      ),
      width: 1.0.sw,
      height: 95.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderGray,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(12.sp),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  'Ads',
                  translate: false,
                  textColor: titleBlack,
                  primaryFont: PRIMARY_FONT_MEDIUM,
                  fontSize: 16,
                ),
                CustomText(
                  'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do',
                  translate: false,
                  textColor: textBlack1,
                  primaryFont: PRIMARY_FONT_REGULAR,
                  fontSize: 11,
                  lines: 2,
                )
              ],
            ),
          ),
          Container(
            width: 48.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  '2:43 am',
                  translate: false,
                  textColor: titleBlack,
                  primaryFont: PRIMARY_FONT_REGULAR,
                  fontSize: 9,
                ),
                SizedBox(height: 6.h,),
                Container(
                  width: 48.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.sp),
                    color: gray0,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://www.niemanlab.org/images/Greg-Emerson-edit-2.jpg'
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

