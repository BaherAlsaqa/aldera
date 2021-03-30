import 'dart:async';
import 'dart:ui';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/CurvePainter.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:aldera/provider/GeneralProvider.dart';
import 'package:aldera/screens/auth/LoginScreen.dart';
import 'package:aldera/screens/home/HomeScreen.dart';
import 'package:aldera/screens/splash/IntroScreens.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iniFCM();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    systemChrome(
        darkMode: true,
        navBarColor: primaryColor,
        navBrightness: Brightness.dark);
    return Container(
      color: primaryColor,
      child: Scaffold(
          backgroundColor: primaryColor,
          body: Stack(
            children: [
              PositionedDirectional(
                  bottom: 0.h,
                  child: Image.asset(ASSETS_NAME_IMAGES+'splash_image.png',
                    fit: BoxFit.fill,)),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
                child: CustomPaint(
                  painter: CurvePainter(),
                ),
              ),
              Column(
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
              )
            ],
          )),
    );
  }

  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // if (getIt<AppSharedPreferences>().getUser() != null) {
    //   if (getIt<AppSharedPreferences>().getUser().details.isActivated == ACTIVATED)
    //     systemChrome(darkMode: true);
    //   else {
    //     if (getIt<AppSharedPreferences>().getUser().accessToken != null)
    //       systemChrome(darkMode: false);
    //     else
    //       systemChrome(darkMode: true);
    //   }

    // systemChrome(darkMode: false);
    systemChrome(
        darkMode: true,
        navBarColor: white,
        navBrightness: Brightness.dark);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
              child: /*getIt<AppSharedPreferences>().getUser().accessToken != null?
                      getIt<AppSharedPreferences>().getUser().details.isActivated == ACTIVATED?
                        fromNotification?
                          type == 'order'?
                            OrderDetailsScreen(null,
                              orderId: int.parse(orderId.toString()),
                              fromNotification: true,) :
                          HomeScreen():
                        HomeScreen():
                      ActivationCodeScreen(true, true):*/
                     HomeScreen(0),
              create: (_) => GeneralProvider()),
        ),
      );
    /*}else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
              child: HomeScreen(),
              create: (_) => GeneralProvider()),
        ),
      );
    }*/
  }

  Future<void> iniFCM() async {
    /*await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );*/

    // firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     // print("fdsfsd");
    //     // print("message"+message.toString());
    //
    //
    //     if(Platform.isIOS){
    //       print("IOS NTF");
    //       var title  =  message['aps']['alert']['title'];
    //       var body  =  message['aps']['alert']['body'];
    //       var scheduledNotificationDateTime =
    //       new DateTime.now().add(new Duration(seconds: 5));
    //       var vibrationPattern = new Int64List(4);
    //       vibrationPattern[0] = 0;
    //       vibrationPattern[1] = 1000;
    //       vibrationPattern[2] = 2000;
    //
    //       var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    //           'your other channel id',
    //           'your other channel name',
    //           'your other channel description',
    //           icon: 'secondary_icon',
    //           vibrationPattern: vibrationPattern,
    //           styleInformation: BigTextStyleInformation(''),
    //           color: const Color.fromARGB(255, 255, 0, 0));
    //       var iOSPlatformChannelSpecifics =
    //       new IOSNotificationDetails(presentAlert: true,);
    //       var platformChannelSpecifics = new NotificationDetails(
    //           androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    //       await flutterLocalNotificationsPlugin.schedule(
    //         0,
    //         title,
    //         body,
    //         scheduledNotificationDateTime,
    //         platformChannelSpecifics,);
    //     }
    //
    //     print("fromNotification = "+message['data']['type'].toString());
    //     print("type = "+message['data']['type'].toString());
    //     print("id = "+message['data']['id'].toString());
    //
    //     fromNotification = Platform.isIOS
    //         ? message['aps']['alert']
    //         : message['data'] != null? true: false;
    //     type = Platform.isIOS?
    //     message['type']:
    //     message['data']['type'] != null?
    //     message['data']['type']:
    //     "0";
    //     orderId = Platform.isIOS?
    //     message['id']:
    //     message['data']['id'] != null?
    //     message['data']['id']:
    //     "-1";
    //
    //     Platform.isIOS ?
    //     _showNotificationWithIconBadge(message)
    //         : _showNotification(message);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("message['data']['type'] = "+message['data']['type'].toString());
    //     fromNotification = Platform.isIOS
    //         ? message['aps']['alert']
    //         : message['data'] != null? true: false;
    //     type = Platform.isIOS
    //         ? message['type']:
    //     message['data']['type'] != null?
    //     message['data']['type']:
    //     "0";
    //     orderId = Platform.isIOS?
    //     message['id']:
    //     message['data']['id'] != null?
    //     message['data']['id']:
    //     "-1";
    //     print("onLaunchMain: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("message['data']['type'] = "+message['data']['type'].toString());
    //     fromNotification = Platform.isIOS
    //         ? message['aps']['alert']
    //         : message['data'] != null? true: false;
    //     type = Platform.isIOS
    //         ? message['type']
    //         : message['data']['type'] != null?
    //     message['data']['type']:
    //     "0";
    //     orderId = Platform.isIOS?
    //     message['id']:
    //     message['data']['id'] != null?
    //     message['data']['id']:
    //     "-1";
    //     Platform.isIOS ?
    //     _showNotificationWithIconBadge(message)
    //         : _showNotification(message);
    //     print("onResumeMain: $message");
    //   },
    // );

  }

  // Future<void> _showNotificationWithIconBadge(Map<String, dynamic> message) async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'icon_badge_channel'+type.toString(),
  //     'icon_badge_name'+type.toString(),
  //     'icon_badge_description'+type.toString(),
  //     styleInformation: BigTextStyleInformation(''),);
  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails(badgeNumber: 1,
  //     presentBadge: true,
  //     presentSound: true,);
  //   var platformChannelSpecifics = NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //       0,
  //       Platform.isIOS? message["title"]: message["notification"]["title"],
  //       Platform.isIOS? message["body"]:message["notification"]["body"], platformChannelSpecifics,
  //       payload: type.toString()+"||"+orderId.toString());
  // }
  // Future<void> _showNotification(Map<String, dynamic> message) async {
  //   var vibrationPattern = new Int64List(4);
  //   vibrationPattern[0] = 0;
  //   vibrationPattern[1] = 1000;
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       "channel id"+type.toString(),
  //       "channel name"+type.toString(),
  //       "channel description"+type.toString(),
  //       styleInformation: BigTextStyleInformation(''),
  //       importance: Importance.Max, priority: Priority.High, ticker: 'ticker',
  //       playSound: true,
  //       color: primaryColor);
  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //       0,
  //       Platform.isIOS? message["title"]: message["notification"]["title"],
  //       Platform.isIOS? message["body"]:message["notification"]["body"],
  //       platformChannelSpecifics,
  //       payload: type.toString()+"||"+ orderId.toString());
  // }
}
