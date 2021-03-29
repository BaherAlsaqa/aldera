import 'dart:io';
import 'dart:ui';

import 'package:aldera/singleton/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:aldera/provider/GeneralProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  bool back;
  String title;
  Color backColor;
  Color titleColor;
  bool showTitle;
  bool customTitle;
  bool home;
  bool search;
  Function onBack;
  bool viewBottom;
  bool fromOrderDetails;
  bool fromNotification;
  String orderNumber;
  TabController tabController;
  List<String> listOfDepartments;
  List<Widget> tabTitle;
  double appBarHeight;
  bool exit;
  bool customBack;

  CustomAppBar(this.backColor,
      {this.back = false,
      this.title,
      this.showTitle = true,
      this.titleColor = textWhite,
      this.customTitle = false,
      this.home = false,
      this.onBack,
      this.search = false,
      this.viewBottom = false,
      this.fromOrderDetails = false,
      this.fromNotification = false,
      this.orderNumber = '',
      this.tabController,
      this.listOfDepartments,
      this.tabTitle,
      this.appBarHeight = kToolbarHeight,
      this.exit = false,
      this.customBack = false});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralProvider>(
      builder: (context, generalProvider, child) {
        return AppBar(
            title: Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 0.w, end: 0.w, top: 5.h, bottom: 0.h),
                    child: CustomText(
                      widget.showTitle ? widget.title : "",
                      translate: !widget.customTitle,
                      fontSize: 20,
                      primaryFont: PRIMARY_FONT_MEDIUM,
                      textColor: widget.titleColor,
                    ),
                  ),
            automaticallyImplyLeading: false,
            centerTitle: false,
            brightness: widget.home? Brightness.dark: null,
            leading: widget.back? Padding(
              padding: EdgeInsetsDirectional.only(
                start: 0.w, end: 0.w, top: 5.h, bottom: 0.h
              ),
              child: IconButton(
                icon: SvgPicture.asset(ASSETS_NAME_APPBAR+'back.svg', width: 8.w,),
                onPressed: (){
                  Navigator.pop(context, true);
                },
              ),
            ): null,
            actions: [
                Container(
                      padding: EdgeInsetsDirectional.only(
                        start: 0.w, end: 0.w, top: 5.h, bottom: 0.h
                      ),
                      width: 50.w,
                      height: 50.w,
                      child: IconButton(
                          onPressed: () {
                            //todo //enter code here
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => CartScreen(null),
                            //   ),
                            // );
                          },
                          icon: SvgPicture.asset(
                            ASSETS_NAME_APPBAR + "notifications.svg",
                            width: 16.w,
                          )),
                    )
            ],
            flexibleSpace: Container(
              width: 1.0.sw,
              height: widget.appBarHeight+widget.appBarHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                  colors: <Color>[
                    secondaryColor,
                    // primaryColor,
                    primaryColor,
                  ], // red to yellow
                ),
              ),
            ),
            backgroundColor: widget.backColor,
            elevation: 0,
            bottom: widget.viewBottom
                ? AppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: 30.h,
                    flexibleSpace: widget.home
                        ? Container(
                            height: 10,
                            color: white,
                          )
                        : Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [primaryColor, white, white],
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                stops: [0.3, 0.3, 0.3],
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 30.h,
                                  width: 376.w,
                                  alignment: AlignmentDirectional.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.only(
                                        topStart: Radius.circular(0.sp),
                                        topEnd: Radius.circular(0.sp),
                                        bottomStart: Radius.circular(30.sp),
                                        bottomEnd: Radius.circular(30.sp)),
                                    color: primaryColor,
                                  ),
                                  child: widget.fromOrderDetails
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            CustomText(
                                              'orderId',
                                              textColor: textWhite,
                                              primaryFont: PRIMARY_FONT_MEDIUM,
                                              fontSize: 17,
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            CustomText(
                                              widget.orderNumber + '#',
                                              translate: false,
                                              textColor: textWhite,
                                              primaryFont: PRIMARY_FONT_MEDIUM,
                                              fontSize: 17,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ),
                                Container(
                                  height: 5.h,
                                  color: white,
                                )
                              ],
                            ),
                          ),
                    elevation: 0,
                    backgroundColor: widget.home ? white : primaryColor,
                  )
                : null);
      },
    );
  }

/*@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.tabController.dispose();
  }*/
}
