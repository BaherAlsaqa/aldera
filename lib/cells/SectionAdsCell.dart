import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/CustomButton.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:aldera/custom_widgets/CustomTextField.dart';
import 'package:aldera/screens/otherScreens/CommentScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SectionAdsCell extends StatelessWidget {
  final TextEditingController comment = TextEditingController();
  final FocusNode focus1 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
          start: 0.w, end: 0.w, top: 0.h, bottom: 14.h),
      width: 1.0.sw,
      height: 315.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderGray1,
          width: 1.w,
        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.sp),
            topRight: Radius.circular(6.sp),
            bottomLeft: Radius.circular(0.sp),
            bottomRight: Radius.circular(0.sp)),
        color: white,
      ),
      child: Stack(
        children: [
          Container(
            height: 224.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(6.sp),
                    topEnd: Radius.circular(6.sp),
                    bottomStart: Radius.circular(23.sp),
                    bottomEnd: Radius.circular(23.sp)),
                boxShadow: [
                  BoxShadow(
                    color: blackShadowColor.withOpacity(0.2),
                    blurRadius: 3.0.sp, // soften the shadow
                    spreadRadius: 0.0.sp, //extend the shadow
                    offset: Offset(
                      0.0.sp, // Move to right 10  horizontally
                      1.0.sp, // Move to bottom 10 Vertically
                    ),
                  )
                ],
                image: DecorationImage(
                  image: NetworkImage(
                      'https://static9.depositphotos.com/1005245/1174/i/600/depositphotos_11747942-stock-photo-successful-and-happy-business-arabic.jpg'),
                  fit: BoxFit.cover,
                )),
          ),
          PositionedDirectional(
            bottom: 58.0.h,
            start: 6.w,
            child: Row(
              children: [
                Container(
                    width: 28.w,
                    height: 28.w,
                    padding: EdgeInsetsDirectional.only(
                        start: 6.w, end: 6.w, top: 0.h, bottom: 0.h),
                    child: SvgPicture.asset(ASSETS_NAME_HOME + 'like.svg')),
                SizedBox(
                  width: 4.w,
                ),
                Container(
                    width: 28.w,
                    height: 28.w,
                    padding: EdgeInsetsDirectional.only(
                        start: 7.w, end: 7.w, top: 0.h, bottom: 0.h),
                    child: SvgPicture.asset(ASSETS_NAME_HOME + 'comment.svg')),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 65.0.h,
            end: 8.w,
            child: Row(
              children: [
                CustomText(
                  '109',
                  translate: false,
                  textColor: textBlackLight,
                  primaryFont: PRIMARY_FONT_MEDIUM,
                  fontSize: 10,
                ),
                SizedBox(
                  width: 5.w,
                ),
                CustomText(
                  'view',
                  textColor: textBlackLight,
                  primaryFont: PRIMARY_FONT_MEDIUM,
                  fontSize: 10,
                ),
              ],
            ),
          ),
          PositionedDirectional(
              bottom: 48.0.h,
              start: 12.w,
              child: Row(
                children: [
                  CustomText(
                    '12',
                    translate: false,
                    textColor: textBlackLight,
                    primaryFont: PRIMARY_FONT_MEDIUM,
                    fontSize: 10,
                  ),
                  SizedBox(width: 5.w,),
                  CustomText(
                    'likes',
                    textColor: textBlackLight,
                    primaryFont: PRIMARY_FONT_MEDIUM,
                    fontSize: 10,
                  ),
                ],
              ),),
          PositionedDirectional(
            bottom: 46.h,
              end: 8.w,
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    CustomText(
                      'viewAll',
                      textColor: subTextBlack,
                      primaryFont: PRIMARY_FONT_REGULAR,
                      fontSize: 9,
                    ),
                    SizedBox(width: 3.w,),
                    CustomText(
                      '3',
                      translate: false,
                      textColor: subTextBlack,
                      primaryFont: PRIMARY_FONT_REGULAR,
                      fontSize: 9,
                    ),
                    SizedBox(width: 3.w,),
                    CustomText(
                      'comments',
                      textColor: subTextBlack,
                      primaryFont: PRIMARY_FONT_REGULAR,
                      fontSize: 9,
                    )
                  ],
                ),
              )
          ),
          PositionedDirectional(
            bottom: 9.5.h,
            start: 10.w,
            child: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(50.sp),
                  topEnd: Radius.circular(50.sp),
                  bottomStart: Radius.circular(50.sp),
                  bottomEnd: Radius.circular(50.sp)
              ),
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.niemanlab.org/images/Greg-Emerson-edit-2.jpg'
                  )
              ),
              color: gray,
            ),
          ),
          ),
          PositionedDirectional(
            bottom: 9.5.h,
            start: 51.9.w,
            child: Container(
              width: 200.w,
              height: 35.h,
              child: CustomTextField(
                  "addComment",
                  comment,
                  focus1,
                  focus1,
                  COMMENT,
                  "pleaseEnterRePassword",
              fontSize: 9,),
            ),
          ),
          PositionedDirectional(
            bottom: 14.h,
            end: 15.5.w,
            child: CustomButton(
              title: 'send',
              width: 60.w,
              height: 21.h,
              color: white,
              textColorValue: subTextBlack,
              borderColor: borderGray1,
              fontSize: 9,
                withOutBackground: true,
              borderWidth: 1,
            ),
          ),
        ],
      ),
    );
  }
}
