import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/CurvePainter.dart';
import 'package:aldera/custom_widgets/CustomButton.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:aldera/screens/auth/LoginScreen.dart';
import 'package:aldera/singleton/AppSharedPreference.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:aldera/utils/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreens extends StatefulWidget {
  @override
  _IntroScreensState createState() => _IntroScreensState();
}

class _IntroScreensState extends State<IntroScreens> {
  int currentPage = 0;
  List<String> introList = [];
  final controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prepareList();
  }

  void prepareList() {
    for (int i = 0; i < 4; i++) {
      introList.add(
          "https://www.voicesofyouth.org/sites/voy/files/images/2019-08/pexels-photo-914931.jpg");
    }
  }

  @override
  Widget build(BuildContext context) {
    systemChrome(
        darkMode: true,
        navBarColor: white,
        navBrightness: Brightness.dark);
    return Container(
      color: white,
      child: Scaffold(
        backgroundColor: white,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
              child: CustomPaint(
                painter: CurvePainter(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 60.h,),
                Expanded(
                    flex: 1,
                    child: SvgPicture.asset(ASSETS_NAME_ICONS + "logo.svg", width: 46.w,)),
                Expanded(
                  flex: 1,
                  child: CustomText(
                    'app_name',
                    textColor: textWhite,
                    primaryFont: PRIMARY_FONT_KHEBRAT_MUSAMEM,
                    fontSize: 33,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: PageView.builder(
                    controller: controller,
                    // scrollDirection: Axis.vertical,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: introList.length,
                    itemBuilder: (context, index) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: 328.w,
                            height: 483.h,
                            margin: EdgeInsetsDirectional.only(
                                start: 24.w, end: 24.w, top: 0.h, bottom: 0.h
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.only(
                                  topStart: Radius.circular(25.sp),
                                  topEnd: Radius.circular(25.sp),
                                  bottomStart: Radius.circular(0.sp),
                                  bottomEnd: Radius.circular(0.sp)
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  introList[currentPage],
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: blackShadowColor.withOpacity(0.3),
                                  blurRadius: 13.0.sp, // soften the shadow
                                  spreadRadius: 0.0.sp, //extend the shadow
                                  offset: Offset(
                                    0.0.sp, // Move to right 10  horizontally
                                    5.0.sp, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      introList.length,
                          (index) => buildDot(index: index),
                    ),
                  ),
                ),
                // SizedBox(height: 10.h,),
                Expanded(
                  flex: 1,
                  child: /*IntroButton(
                    text: 'skip',
                    press: () {

                    },
                  ),*/
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 30.w, end: 30.w, top: 0.h, bottom: 0.h
                    ),
                    child: CustomButton(
                      title: 'skip',
                      fontSize: 19,
                      function: () {
                        getIt<AppSharedPreferences>()
                            .setOpenIntro(true);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    ),
                  )
                ),
                SizedBox(height: 30.h,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsetsDirectional.only(start: 5),
      height: 9.w,
      width: 9.w,
      decoration: BoxDecoration(
        color: currentPage == index ? primaryColor : borderGray,
        borderRadius: BorderRadius.circular(10.0.w),
      ),
    );
  }
}
