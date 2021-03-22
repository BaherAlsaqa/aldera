import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagesProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  LanguagesProvider({@required this.sharedPreferences});

  Locale _appLocale = Locale('ar');

  Locale get appLocal => _appLocale ?? Locale("ar");

  fetchLocale() async {
    sharedPreferences.reload();
    if (sharedPreferences.getString('language_code') == null) {
      _appLocale = Locale('ar');
      print("APPLocal null");

      return Null;
    }
    _appLocale = Locale(sharedPreferences.getString('language_code'));
    this._appLocale = _appLocale;
    notifyListeners();
    print("APPLocal $_appLocale");

    return _appLocale;
  }

  void changeLanguage(
      BuildContext context, Locale type, String lang, Function onDone) async {
    print("changeLanguage >> "+lang);
    _appLocale = type;
    // if (_appLocale == type) {
    //   return;
    // }
   /* if (getIt<AppSharedPreferences>().getUserToken() != null) {
      await getIt<APIsData>().updatelanguage(lang).then(
        (value) async {
          var preferences = await SharedPreferences.getInstance();
          preferences.reload();
          Map userMap = jsonDecode(preferences.getString('user'));
          UserModel user = UserModel.fromJson(userMap);
          print('user.accessToken: ${user.accessToken}');
          getIt<Dio>().options.headers = {
            "Authorization": "Bearer ${getIt<AppSharedPreferences>().getUserToken()}",
            'Accept-Language': getIt<LanguagesProvider>().appLocal.languageCode.toLowerCase(),
            'Accept': 'application/json'
          };
          print({
            'Accept-Language': getIt<LanguagesProvider>().appLocal.languageCode.toLowerCase(),
            "Authorization": "Bearer ${user.accessToken}",
            'Accept': 'application/json'
          });
          if (type.languageCode.toLowerCase() == "ar") {
            _appLocale = Locale("ar");
            sharedPreferences.setString('language_code', 'ar');
            sharedPreferences.setString('countryCode', 'AR');
          } else {
            _appLocale = Locale("en");
            sharedPreferences.setString('language_code', 'en');
            sharedPreferences.setString('countryCode', 'US');
          }
          print(
              "language_code aaa--- ${sharedPreferences.getString("language_code")}");
          print(
              "language_code aaa--- ${sharedPreferences.getString("countryCode")}");
          sharedPreferences.reload();
          notifyListeners();
          onDone();
        },
      ).catchError((error) {
        print("catchError >> changeLanguage = " + error.toString());
        showError(context, error);
      });
    } else {*/
      print("no user");

      getIt<Dio>().options.headers = {
        'Accept-Language': getIt<LanguagesProvider>().appLocal.languageCode.toLowerCase(),
        'Accept': 'application/json'
      };
      if (type.languageCode.toLowerCase() == "ar") {
        _appLocale = Locale("ar");
        sharedPreferences.setString('language_code', 'ar');
        sharedPreferences.setString('countryCode', 'SA');
      } else {
        _appLocale = Locale("en");
        sharedPreferences.setString('language_code', 'en');
        sharedPreferences.setString('countryCode', 'US');
      }
      print(
          "language_code aaa--- ${sharedPreferences.getString("language_code")}");
      print(
          "language_code aaa--- ${sharedPreferences.getString("countryCode")}");
      sharedPreferences.reload();
      onDone();
      notifyListeners();
    }
  /*}*/
}
