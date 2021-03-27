import 'package:aldera/cells/SectionCell.dart';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/custom_widgets/Banners.dart';
import 'package:aldera/models/home/Images.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionsPage extends StatefulWidget {
  @override
  _SectionsPageState createState() => _SectionsPageState();
}

class _SectionsPageState extends State<SectionsPage> {
  @override
  Widget build(BuildContext context) {
    systemChrome(
        darkMode: true,
        navBarColor: white,
        navBrightness: Brightness.dark);
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: white,
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
                  padding: EdgeInsetsDirectional.only(
                    start: 25.w, end: 25.w, top: 0.h, bottom: 0.h
                  ),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) =>
                    SectionCell(index),
                    staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(index == 0 || index == 1 ||
                        index == 3 || index == 4? 1: 2, 1),
                    mainAxisSpacing: 18.0,
                    crossAxisSpacing: 18.0,
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
