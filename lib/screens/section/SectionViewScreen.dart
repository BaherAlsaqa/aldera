import 'package:aldera/cells/SectionAdsCell.dart';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/custom_widgets/Banners.dart';
import 'package:aldera/custom_widgets/CustomAppBar.dart';
import 'package:aldera/models/home/Images.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionViewScreen extends StatefulWidget {
  @override
  _SectionViewScreenState createState() => _SectionViewScreenState();
}

class _SectionViewScreenState extends State<SectionViewScreen> {
  @override
  Widget build(BuildContext context) {
    systemChrome(
        darkMode: true,
        navBarColor: white,
        navBrightness: Brightness.dark);
    return Container(
      color: white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: CustomAppBar(
            white,
            back: true,
            title: 'sectionsView',
            home: true,
            appBarHeight: kToolbarHeight+10.h,
          ),
          body: Column(
            children: [
              Banners(
                images: [
                  Images("https://www.voicesofyouth.org/sites/voy/files/images/2019-08/pexels-photo-914931.jpg"),
                  Images("https://www.voicesofyouth.org/sites/voy/files/images/2019-08/pexels-photo-914931.jpg"),
                  Images("https://www.voicesofyouth.org/sites/voy/files/images/2019-08/pexels-photo-914931.jpg"),
                ],
              ),
              Expanded(
                child: Container(
                  color: chatBackColor,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) =>
                        SectionAdsCell(),
                    padding: EdgeInsetsDirectional.only(
                        start: 25.w, end: 25.w, top: 0.h, bottom: 0.h
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
