import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/CustomAppBar.dart';
import 'package:aldera/screens/ads/AddAdsScreen.dart';
import 'package:aldera/screens/home/tabs/AboutPage.dart';
import 'package:aldera/screens/home/tabs/AccountPage.dart';
import 'package:aldera/screens/home/tabs/HomePage.dart';
import 'package:aldera/screens/home/tabs/SectionsPage.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:aldera/utils/language.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  int index;

  HomeScreen(this.index);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _children;
  List<Widget> iconsTaps;
  List<Widget> activeIconsTaps;
  List<String> iconsName;
  List<String> activeIconsName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _children = [
      AccountPage(),
      Homepage(),
      SectionsPage(),
      AboutPage()
    ];
    iconsName = [
      "https://upload.wikimedia.org/wikipedia/commons/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg",
      ASSETS_NAME_HOME+"home_inactive.svg",
      ASSETS_NAME_HOME+"sections_inactive.svg",
      ASSETS_NAME_HOME+"about_inactive.svg",
      ASSETS_NAME_HOME+"about_inactive.svg",
    ];
    activeIconsName = [
      "https://upload.wikimedia.org/wikipedia/commons/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg",
      ASSETS_NAME_HOME+"home_active.svg",
      ASSETS_NAME_HOME+"sections_active.svg",
      ASSETS_NAME_HOME+"about_active.svg",
      ASSETS_NAME_HOME+"about_active.svg",
    ];

    iconsTaps = [
      // SvgPicture.asset(iconsName[0]),
      for (int i = 0; i < 5; i++) i==0? Container(
        width: 22.w,
        height: 22.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.sp),
          color: gray3,
          border: Border.all(
            color: primaryColor.withOpacity(0.40),
            width: 1.w
          ),
          image: DecorationImage(
            image: NetworkImage(iconsName[i], scale: 22.w),)
          )
      ):
      SvgPicture.asset(iconsName[i])
    ];
    activeIconsTaps = [
      // SvgPicture.asset(iconsName[0]),
      for (int i = 0; i < 5; i++) i==0? Container(
        width: 21.w,
        height: 21.w,
        child: CircleAvatar(backgroundImage: NetworkImage(activeIconsName[i], scale: 21.w),
            radius: 25.sp),
      ):
      SvgPicture.asset(activeIconsName[i])
    ];
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
        appBar: CustomAppBar(
          white,
          title: 'home',
          home: true,
          appBarHeight: kToolbarHeight+10.h,
        ),
        body: _children[widget.index],
        bottomNavigationBar: myCustomBottomNavigation(),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.endDocked,
        floatingActionButton: Container(
          margin: EdgeInsetsDirectional.only(
            start: 0.w, end: 10.w, top: 62.h, bottom: 0.h
          ),
          width: 40.w,
          height: 40.w,
          child: FloatingActionButton(
            elevation: 0,
            // backgroundColor: white,
            onPressed: () {
              _incrementTab(1);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAdsScreen(),
                ),
              );
            },
            // tooltip: 'Increment',
            child: SvgPicture.asset(ASSETS_NAME_HOME+'add_ads.svg', width: 46.w,)
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      widget.index = index;
    });
  }
  Widget myCustomBottomNavigation() {
    return Container(
      padding: EdgeInsets.only(left: 0.02.sw, right: 0.02.sw, top: 2.h),
      height: 65.h,
      width: 1.sw,
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: blackShadowColor.withOpacity(0.1),
            blurRadius: 20.0.sp, // soften the shadow
            spreadRadius: -5.0.sp, //extend the shadow
            offset: Offset(
              0.0.sp, // Move to right 10  horizontally
              -15.0.sp, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: BottomNavigationBar(
        onTap: onTabTapped,
        elevation: 0,
        currentIndex: widget.index,
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: selectedBottomNavTextColor,
        selectedLabelStyle: TextStyle(
          fontSize: 10.ssp,
          fontFamily: PRIMARY_FONT_REGULAR,
          height: 2.0
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10.ssp,
          fontFamily: PRIMARY_FONT_REGULAR,
          color: bottomNavTextColor,
          height: 2.0
        ),
        items: [
          BottomNavigationBarItem(
            icon: iconsTaps[0],
            label: getTranslated(context, 'account'),
            activeIcon: myActiveIcon(activeIconsTaps[0]),
          ),
          BottomNavigationBarItem(
            icon: iconsTaps[1],
            label: getTranslated(context, 'home'),
            activeIcon: myActiveIcon(activeIconsTaps[1]),
          ),
          BottomNavigationBarItem(
            icon: iconsTaps[2],
            label: getTranslated(context, 'sections'),
            activeIcon: myActiveIcon(activeIconsTaps[2]),
          ),
          BottomNavigationBarItem(
            icon: iconsTaps[3],
            label: getTranslated(context, 'about'),
            activeIcon: myActiveIcon(activeIconsTaps[3]),
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: '',
            activeIcon: Container(),
          ),
        ],
      ),
    );
  }
  Widget myActiveIcon(Widget iconTap) {
    return iconTap;
  }

  void _incrementTab(index) {
    setState(() {
      widget.index = index;
    });
  }
}
