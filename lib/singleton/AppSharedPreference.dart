import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  final SharedPreferences sharedPreferences;

  AppSharedPreferences({@required this.sharedPreferences});

  static const OPEN_FIRST_INTRO = 'open_first_intro';
  static const FIRST_CART_AFTER_CLEAN = 'first_cart_after_clean';
  static const USER = 'user';
  static const SETTINGS = 'settings';
  static const CART_LIST = 'cartList';
  static const CART_DATE = 'cartDate';
  static const CURRENT_ORDER_ID = 'currentOrderId';

  Future<void> clear() {
    sharedPreferences.remove('open_first_intro');
    sharedPreferences.remove('first_cart_after_clean');
    sharedPreferences.remove('user');
    sharedPreferences.remove('settings');
    sharedPreferences.reload();
  }


  Future<void> setOpenIntro(bool open) async {
    return await sharedPreferences.setBool(OPEN_FIRST_INTRO, open);
  }

  bool getOpenIntro() {
    return sharedPreferences.getBool(OPEN_FIRST_INTRO) ?? false;
  }

  Future<void> setFirstCartAfterClean(bool open) async {
    return await sharedPreferences.setBool(FIRST_CART_AFTER_CLEAN, open);
  }

  bool getFirstCartAfterClean() {
    return sharedPreferences.getBool(FIRST_CART_AFTER_CLEAN) ?? false;
  }

  Future<void> setCartDate(String cartDate) async {
    return await sharedPreferences.setString(CART_DATE, cartDate);
  }

  String getCartDate() {
    return sharedPreferences.getString(CART_DATE);
  }

  Future<void> setCurrentOrderId(String orderId) async {
    return await sharedPreferences.setString(CURRENT_ORDER_ID, orderId);
  }

  String getCurrentOrderId() {
    return sharedPreferences.getString(CURRENT_ORDER_ID);
  }

//   Future<void> setUser(UserModel userModel) async {
//     String user = jsonEncode(userModel);
//     return await sharedPreferences.setString(USER, user);
//   }
//
//   UserModel getUser() {
//     if(sharedPreferences.getString(USER) == null){
//       return null;
//     }
//     var map =  jsonDecode(sharedPreferences.getString(USER));
//     return UserModel.fromJson(map);
//   }
}
