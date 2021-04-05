import 'package:aldera/cells/CommentCell.dart';
import 'package:aldera/cells/NotificationCell.dart';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/custom_widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Scaffold(
        backgroundColor: white,
        appBar: CustomAppBar(
          white,
          back: true,
          title: 'commentsTitle',
          home: true,
          appBarHeight: kToolbarHeight+10.h,
        ),
        body: ListView.builder(
          padding: EdgeInsetsDirectional.only(
            start: 26.w, end: 26.w, top: 26.h, bottom: 26.h
          ),
            itemCount: 10,
            itemBuilder: (context, index){
          return CommentCell();
        }),
      ),
    );
  }
}
