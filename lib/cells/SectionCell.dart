import 'package:aldera/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionCell extends StatelessWidget {
  int index;
  SectionCell(this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(15.sp),
          topEnd: Radius.circular(15.sp),
          bottomStart: Radius.circular(15.sp),
          bottomEnd: Radius.circular(15.sp)
       ),
        color: chatBackColor,
        image: DecorationImage(
          image: NetworkImage(
            'https://www.voicesofyouth.org/sites/voy/files/images/2019-08/pexels-photo-914931.jpg',
          ),
          fit: BoxFit.cover
        )
      ),
    );
  }
}
