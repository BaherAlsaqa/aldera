import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:aldera/screens/section/SectionViewScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionCell extends StatelessWidget {
  int index;

  SectionCell(this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SectionViewScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(15.sp),
              topEnd: Radius.circular(15.sp),
              bottomStart: Radius.circular(15.sp),
              bottomEnd: Radius.circular(15.sp)),
          color: chatBackColor,
          image: DecorationImage(
              image: NetworkImage(
                'https://www.voicesofyouth.org/sites/voy/files/images/2019-08/pexels-photo-914931.jpg',
              ),
              fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
              color: blackShadowColor.withOpacity(0.24),
              blurRadius: 10.0.sp, // soften the shadow
              spreadRadius: 0.0.sp, //extend the shadow
              offset: Offset(
                0.0.sp, // Move to right 10  horizontally
                7.0.sp, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(15.sp),
                    topEnd: Radius.circular(15.sp),
                    bottomStart: Radius.circular(15.sp),
                    bottomEnd: Radius.circular(15.sp)),
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  stops: [0.0, 2.0],
                  colors: <Color>[
                    Colors.transparent.withOpacity(0.0),
                    Colors.black.withOpacity(0.7),
                  ], // red to yellow
                ),
              ),
            ),
            PositionedDirectional(
              bottom: 19.h,
              start: 12.w,
              child: CustomText(
                'Kuwait News',
                translate: false,
                textColor: textWhite,
                primaryFont: PRIMARY_FONT_REGULAR,
                fontSize: 13,
              ),
            ),
            PositionedDirectional(
                bottom: 19.h,
                end: 12.w,
                child: Container(
                  width: 18.w,
                  height: 18.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(25.sp),
                        topEnd: Radius.circular(25.sp),
                        bottomStart: Radius.circular(25.sp),
                        bottomEnd: Radius.circular(25.sp)),
                    color: primaryColor,
                  ),
                  child: CustomText(
                    '20',
                    translate: false,
                    textColor: textWhite,
                    primaryFont: PRIMARY_FONT_MEDIUM,
                    fontSize: 10,
                    textAlign: TextAlign.center,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
