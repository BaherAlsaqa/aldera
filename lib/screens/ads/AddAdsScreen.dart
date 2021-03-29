import 'package:aldera/cells/SelectSectionCell.dart';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/CustomAppBar.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
class AddAdsScreen extends StatefulWidget {
  @override
  _AddAdsScreenState createState() => _AddAdsScreenState();
}

class _AddAdsScreenState extends State<AddAdsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: CustomAppBar(
            white,
            back: true,
            title: 'addAds',
            home: true,
            appBarHeight: kToolbarHeight+10.h,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: 25.w, end: 25.w, top: 30.h, bottom: 16.h
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        'attachment',
                        textColor: textBlack,
                        primaryFont: PRIMARY_FONT_REGULAR,
                        fontSize: 14,
                      ),
                      SvgPicture.asset(ASSETS_NAME_HOME+'attachment.svg', width: 20.w),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Container(
                    width: 1.0.sw,
                    height: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(6.sp),
                        topEnd: Radius.circular(6.sp),
                        bottomStart: Radius.circular(6.sp),
                        bottomEnd: Radius.circular(6.sp)
                     ),
                      color: gray5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ASSETS_NAME_HOME+'picture.svg',
                          color: gray6, width: 110.w, height: 80.h,),
                        CustomText(
                          'imagePreview',
                          textColor: textBlack,
                          primaryFont: PRIMARY_FONT_REGULAR,
                          fontSize: 14,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 27.h,),
                  CustomText(
                    'selectSections',
                    textColor: textBlack,
                    primaryFont: PRIMARY_FONT_REGULAR,
                    fontSize: 14,
                  ),
                  SizedBox(height: 16.h,),
                  ListView.builder(
                    itemCount: 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return SelectSectionCell(index, (){

                        });
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
