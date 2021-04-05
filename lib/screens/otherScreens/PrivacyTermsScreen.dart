import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/AccountCurvePainter.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
class PrivacyTermsScreen extends StatefulWidget {
  @override
  _PrivacyTermsScreenState createState() => _PrivacyTermsScreenState();
}

class _PrivacyTermsScreenState extends State<PrivacyTermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
                child: CustomPaint(
                  painter: AccountCurvePainter(
                      moveTo: 0.35,
                      pathX2: 2.50,
                      pathY2: 0.28
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: 0.w, end: 0.w, top: 111.h, bottom: 0.h
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(ASSETS_NAME_ICONS + "logo.svg", width: 46.w,),
                    CustomText(
                      'app_name',
                      textColor: textWhite,
                      primaryFont: PRIMARY_FONT_KHEBRAT_MUSAMEM,
                      fontSize: 33,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              PositionedDirectional(
                top: 319.h,
                start: 31.w,
                child: CustomText(
                  'privacyTerms',
                  textColor: textBlack,
                  primaryFont: PRIMARY_FONT_MEDIUM,
                  fontSize: 16,
                  textAlign: TextAlign.start,
                ),
              ),
              PositionedDirectional(
                top: 346.h,
                start: 35.w,
                end: 15.w,
                child: Html(
                  data: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium ",
                  style: {
                    "p": Style(
                      fontSize: FontSize.small,
                      fontFamily: PRIMARY_FONT_REGULAR,
                      color: textBlack,
                      textAlign: TextAlign.start,
                    ),
                  },
                  onLinkTap: (url) {
                    print("Opening $url...");
                  },
                ),)
            ],
          ),
        ),
      ),
    );
  }
}
