import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/custom_widgets/CustomText.dart';
import 'package:aldera/models/BodyAPIModel.dart';
import 'package:aldera/provider/LanguageProvider.dart';
import 'package:aldera/utils/language.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'APIsData.dart';
import 'AppSharedPreference.dart';

final getIt = GetIt.instance;
final firebaseMessaging = FirebaseMessaging();

Future<void> init() async {
  getIt.registerLazySingleton<AppSharedPreferences>(
          () => AppSharedPreferences(sharedPreferences: getIt()));

  getIt.registerLazySingleton<LanguagesProvider>(
          () => LanguagesProvider(sharedPreferences: getIt()));

  getIt.registerLazySingleton<APIsData>(() => APIsData(client: getIt()));

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  Dio client = Dio(
    BaseOptions(
      headers: {
        'Accept-Language': 'ar',
        'Accept': 'application/json'
      },
    ),
  );

  getIt.registerLazySingleton<Dio>(() => client);
  getIt.registerLazySingleton(() => http.Client());

  getIt.registerLazySingleton(() async => await SharedPreferences.getInstance());

  refreshToken();
}

systemChrome({bool darkMode, Color navBarColor = white,
  Brightness navBrightness = Brightness.light}){
  if(darkMode)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: navBrightness,
        systemNavigationBarDividerColor: navBrightness == Brightness.dark?
        white: black,
        systemNavigationBarColor: navBarColor));
  else
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: navBarColor));
}

refreshToken({bool fromLogin = false}) async {
  print("refreshToken .... ");
  var preferences = await SharedPreferences.getInstance();
  preferences.reload();
  // if (preferences.getString('user') != null) {
  //   Map userMap = jsonDecode(preferences.getString('user'));
  //   UserModel user = UserModel.fromJson(userMap);
  //
  //   firebaseMessaging.subscribeToTopic("user_${user.id}");
  //   firebaseMessaging.subscribeToTopic("clients");
  //   if(fromLogin)
  //     firebaseMessaging.unsubscribeFromTopic("visitors");
  //
  //   String accessToken = user.accessToken;
  //   // debugPrint('user.accessToken: $accessToken');
  //   getIt<Dio>().options.headers = {
  //     "Authorization": "Bearer $accessToken",
  //     'Accept-Language':
  //     getIt<LanguagesProvider>().appLocal.languageCode.toLowerCase(),
  //     'Accept': 'application/json'
  //   };
  //
  //   // print(getIt<Dio>().options.headers);
  // }else {
    firebaseMessaging.subscribeToTopic("visitors");
    getIt<Dio>().options.headers = {
      'Accept-Language': getIt<LanguagesProvider>().appLocal.languageCode
          .toLowerCase(),
      'Accept': 'application/json'
    };
    // print("user = null >> " + getIt<Dio>().options.headers.toString());
  // }
}

var alertStyle;

showError(BuildContext context, String title, error, {bool fromCart = false}) {
  print("showError = " + error.toString());
  alertStyle = AlertStyle(
    animationType: AnimationType.shrink,
    isCloseButton: false,
    isOverlayTapDismiss: true,
    descStyle:
    TextStyle(color: black, fontSize: 16.ssp, fontFamily: PRIMARY_FONT_REGULAR),
    animationDuration: Duration(milliseconds: 300),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.sp),
      side: BorderSide(
        color: gray,
      ),
    ),
    titleStyle:
    TextStyle(color: title == NOTE? Colors.lightBlue: Colors.red, fontSize: 20.ssp, fontFamily: PRIMARY_FONT_MEDIUM),
  );
  if (error is DioError) {
    print("showError = " + (error as DioError).error.toString());
//    print("showError = "+(error as DioError).response.data.toString());
    BodyAPIModel errorMoadel;
    if ((error as DioError).response != null) {
      final jsonData = json.decode(error.response.toString());
      print("(error as DioError).response != null >>> " +
          error.response.toString());
      errorMoadel = BodyAPIModel.fromJson(jsonData);
    } else {
      errorMoadel = BodyAPIModel(error.type);
    }
    Alert(
      style: alertStyle,
      type: errorMoadel.status == 401? AlertType.info: AlertType.error,
      context: context,
      title: getTranslated(context, title),
      desc: errorMoadel.status == 401?
      getTranslated(context, "youMustBeLoggedIn"):
      errorMoadel.message,
      onWillPopActive: errorMoadel.status == 401,
      buttons: [
        DialogButton(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 0.w, end: 0.w, top: 3.h, bottom: 0.h
            ),
            child: CustomText(
              errorMoadel.status == 401?'login': 'ok',
              textColor: white,
              primaryFont: PRIMARY_FONT_MEDIUM,
              fontSize: 14,
              textAlign: TextAlign.center,
            ),
          ),
          onPressed: () {
            if(errorMoadel.status == 401){
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => LoginScreen(fromCart: fromCart),
              //         ),
              //         (route) => false);
            }else {
              Navigator.pop(context, true);
            }
          },
          color: primaryColor,
          radius: BorderRadius.circular(15.sp),
        ),
        if(errorMoadel.status == 401)
          DialogButton(
            padding: EdgeInsets.only(
              right: 0.w, left: 0.w, top: 3.h, bottom: 0.h
            ),
            child: CustomText(
              'home',
              textColor: white,
              primaryFont: PRIMARY_FONT_MEDIUM,
              fontSize: 14,
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //       builder: (_) => HomeScreen(),
              //     ),
              //         (route) => false);
            },
            color: secondaryColor,
            radius: BorderRadius.circular(15.sp),
          ),
      ],)
        .show();
  } else {
    print("showError >>> else");

    Alert(
      style: alertStyle,
      type: AlertType.error,
      context: context,
      title: getTranslated(context, title),
      desc: getTranslated(context, "Please try again later"),
      buttons: [
        DialogButton(
          child: CustomText(
            'ok',
            textColor: white,
            primaryFont: PRIMARY_FONT_MEDIUM,
            fontSize: 18,
          ),
          onPressed: () => Navigator.pop(context),
          color: primaryColor,
          radius: BorderRadius.circular(15.sp),
        ),
      ],)
        .show();
  }
}

showAlertString(BuildContext context, String title, String error, int type,
    {bool translate = true, bool fromSearch = false, Function onDone}) {
  Alert(
    style: AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: !fromSearch,
      descStyle:
      TextStyle(color: black, fontSize: 16.ssp, fontFamily: PRIMARY_FONT_REGULAR),
      animationDuration: Duration(milliseconds: 300),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.sp),
        side: BorderSide(
          color: gray,
        ),
      ),
      titleStyle: TextStyle(
          color: type == 1? Colors.red: type == 2?
          Colors.blue: type == 3? Colors.green: Colors.red,
          fontSize: 18.ssp, fontFamily: PRIMARY_FONT_REGULAR),
    ),
    type: type == 1? AlertType.error:
    type == 2? AlertType.info:
    type == 3? AlertType.success:
    AlertType.error,
    context: context,
    title: getTranslated(context, title),
    desc: translate? getTranslated(context, error): error,
    buttons: [
      DialogButton(
        child: CustomText(
          'ok',
          textColor: white,
          primaryFont: PRIMARY_FONT_MEDIUM,
          fontSize: 18,
        ),
        onPressed: () {
          Navigator.pop(context, true);
          if(fromSearch)
            onDone();
        },
        color: primaryColor,
        radius: BorderRadius.circular(15.sp),
      ),
    ],)
      .show();
}

Future<File> getImageCrop(File imageFile) async {
  final imagePicker = ImagePicker();
  PickedFile image = await imagePicker.getImage(source: ImageSource.gallery);
  imageFile = File(image.path);
  var i = await imageFile.readAsBytes();
  print('Select image readAsBytes = ' + i.length.toString());
  return _cropImage(imageFile);
}

Future<File> _cropImage(File imageFile) async {
  File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      maxWidth: 1200,
      maxHeight: 1200,
      compressQuality: 50,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: primaryColor,
          toolbarWidgetColor: white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Cropper',
      ));
  if (croppedFile != null) {
    imageFile = croppedFile;
    var c = await imageFile.readAsBytes();
    print("Select image after cropp = "+c.length.toString());
    return imageFile;
  }
}

