import 'package:aldera/cells/NotificationCell.dart';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/custom_widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Scaffold(
        backgroundColor: white,
        appBar: CustomAppBar(
          white,
          back: true,
          title: 'notifications',
          home: true,
          appBarHeight: kToolbarHeight+10.h,
        ),
        body: ListView.builder(
          padding: EdgeInsetsDirectional.only(
            start: 26.w, end: 26.w, top: 26.h, bottom: 26.h
          ),
            itemCount: 10,
            itemBuilder: (context, index){
          return NotificationCell();
        }),
      ),
    );
  }
}
