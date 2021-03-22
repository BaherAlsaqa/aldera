import 'dart:io';
import 'dart:ui';

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
      this.titleColor = primaryColor,
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
            title: !widget.home
                ? Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 0.w, end: 0.w, top: 5.h, bottom: 0.h),
                    child: CustomText(
                      widget.showTitle ? widget.title : "",
                      translate: !widget.customTitle,
                      fontSize: 20,
                      primaryFont: PRIMARY_FONT_MEDIUM,
                      textColor: widget.titleColor,
                    ),
                  )
                : SvgPicture.asset(
                    ASSETS_NAME_HOME + "logo.svg",
                    width: 50.w,
                  ),
            leading: widget.home
                ? IconButton(
                    icon: SvgPicture.asset(
                      ASSETS_NAME_APPBAR + "menu.svg",
                      width: 23.w,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    })
                : widget.back
                    ? Container(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: IconButton(
                              onPressed: () {
                                if(!widget.exit) {
                                  if (widget.fromNotification) {
                                    // Navigator.pushAndRemoveUntil(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ChangeNotifierProvider(
                                    //               child: HomeScreen(),
                                    //               create: (context) =>
                                    //                   GeneralProvider(),
                                    //             )),
                                    //         (Route<dynamic> route) => false);
                                  } else {
                                    if (widget.title != 'cart' || !widget.customBack) {
                                      Navigator.pop(context);
                                    }
                                    widget.onBack();
                                  }
                                }else{
                                  Platform.isAndroid?
                                    SystemNavigator.pop():
                                  exit(0);
                                }
                              },
                              icon: Directionality(
                                textDirection: TextDirection.rtl,
                                child: SvgPicture.asset(
                                  ASSETS_NAME_ICONS + "back_arrow.svg",
                                  width: 10.w,
                                  matchTextDirection: true,
                                  color: white,
                                ),
                              )),
                        ),
                      )
                    : Container(
                        width: 0.0.w,
                        height: 0.0.h,
                      ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: [
              if (widget.search)
                IconButton(
                    onPressed: () {
                      //todo //enter code here
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SearchScreen(),
                      //   ),
                      // );
                    },
                    icon: SvgPicture.asset(
                        ASSETS_NAME_ICONS + "search_appbar.svg"))
              else if (widget.home)
                Consumer<GeneralProvider>(
                  builder: (context, generalProvider, child) {
                    return Container(
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
                            ASSETS_NAME_APPBAR + "cart.svg",
                            width: 24.w,
                          )),
                    );
                  }
                )
            ],
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
