import 'dart:convert';

import 'package:aldera/models/BodyAPIModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/singleton/APIsData.dart';
import 'package:aldera/singleton/AppSharedPreference.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:aldera/utils/language.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralProvider extends ChangeNotifier {
  bool _unauthenticated = false;
  bool _isLoading = false;



  //todo//////////////////////////showErrorOrUnauth////////////////////////////
  void showErrorOrUnauth(
      BuildContext context, String title, dynamic error, {bool fromCart = false}) async {
    BodyAPIModel errorModel;
    if ((error as DioError).response != null) {
      final jsonData = json.decode(error.response.toString());
      errorModel = BodyAPIModel.fromJson(jsonData);
      if (errorModel.status == 401) {
        _unauthenticated = true;
        await notifyListeners();
        showError(context, NOTE, error, fromCart: fromCart);
      } else {
        showError(context, title, error);
      }
    } else {
      Alert(
        style: alertStyle,
        type: AlertType.error,
        context: context,
        title: getTranslated(context, title),
        desc: getTranslated(context, "Please try again later"),
        buttons: [
          DialogButton(
            child: Text(
              getTranslated(context, "OK"),
              style: TextStyle(
                  color: white,
                  fontSize: 42.ssp,
                  fontFamily: PRIMARY_FONT_REGULAR),
            ),
            onPressed: () => Navigator.pop(context),
            color: primaryColor,
            radius: BorderRadius.circular(10),
          ),
        ],
      ).show();
    }
  }
}
