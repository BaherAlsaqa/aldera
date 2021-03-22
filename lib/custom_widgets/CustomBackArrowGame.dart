import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aldera/singleton/dio.dart';

class CustomBackArrowGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
        top: 40.h,
        end: 5.w,
        child: IconButton(
          iconSize: 50.w,
          icon: SvgPicture.asset('assets/images/Buttons/back.svg'),
          onPressed: (){
            systemChrome(darkMode: false);
            Navigator.pop(context);
          },
        )
    );
  }
}
