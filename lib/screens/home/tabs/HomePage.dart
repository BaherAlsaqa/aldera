import 'dart:io';
import 'dart:math';

import 'package:aldera/cells/MessageCell.dart';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/Banners.dart';
import 'package:aldera/models/home/Images.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:aldera/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();
  String messageControllerValue;
  ScrollController scrollController = ScrollController();
  DateTime dateTime = DateTime.now();
  Locale locale = Locale('en');
  String languageCode = Platform.localeName.split('_')[0];
  String countryCode = Platform.localeName.split('_')[1];
  // Recording _recording = new Recording();
  bool _isRecording = false;
  bool _isUploaded = false;
  Random random = new Random();
  String audioURL;
  String fileName;
  var timerProvider;
  String minutes = "0", second = "0";
  int uploadProgress = 0;
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
                  child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: /*docs != null ? docs.length : 0,*/10,
                      itemBuilder: (context, i) {
                        return MessageCell(
                          // user: /*docs[i].data()['user']*/'user',
                          text: /*docs[i].data()['text']*/'لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور',
                          type: /*docs[i].data()['type']*/TEXT,
                          // audioTime: docs[i].data()['audioTime'],
                          timestamp: /*docs[i].data()['timestamp']*/'March 1, 2021 at 7:21:20 PM UTC+2',
                          // audioPlayer: audioPlayer,
                          mine: i%2==0?true: false,
                        );
                      }),
                ),
              ),
              // Container(
              //   width: 1.0.sw,
              //   height: 50.h,
              //   child: IntrinsicHeight(
              //     child: TextField(
              //         minLines: 1,
              //         maxLines: 4,
              //         style: TextStyle(
              //     fontFamily: PRIMARY_FONT_REGULAR,
              //     fontSize: 15.ssp,
              //         ),
              //         // onSubmitted: (value) => sendChat('text'),
              //         controller: messageController,
              //         cursorColor: primaryColor,
              //         decoration: InputDecoration(
              //     contentPadding: EdgeInsetsDirectional.only(
              //         top: 0, bottom: 0, start: 10.w, end: 10.w),
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(20)),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20),
              //       borderSide: BorderSide(color: containerTFMessage, width: 0),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20),
              //       borderSide: BorderSide(color: containerTFMessage, width: 0),
              //     ),
              //     filled: true,
              //     fillColor: containerTFMessage,
              //     hintText: getTranslated(context, "typeMessage"),
              //     hintStyle: TextStyle(
              //         fontFamily: PRIMARY_FONT_REGULAR,
              //         fontSize: 12.ssp),
              //         ),
              //       ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
