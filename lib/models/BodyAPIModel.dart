import 'package:dio/dio.dart';

class BodyAPIModel<T> {
   bool success;
   String message;
   T data;
   int status;

  BodyAPIModel(DioErrorType errorType) {

    if ( errorType == DioErrorType.DEFAULT){
      print("DioErrorType.DEFAULT");
      success = false;
      message = "Please try again later";
      status = 0;
    }
    else if ( errorType == DioErrorType.CONNECT_TIMEOUT){
      success = false;
      message = "CONNECT TIMEOUT";
      status = 0;
    }

    else if ( errorType == DioErrorType.RECEIVE_TIMEOUT){
      success = false;
      message = "RECEIVE TIMEOUT";
      status = 0;
    }
    else if ( errorType == DioErrorType.SEND_TIMEOUT){
      success = false;
      message = "SEND TIMEOUT";
      status = 0;
    }else {
      print("DioErrorType.DEFAULT = else");
      success = false;
      message = "Please try again later";
      status = 0;
    }
//    if ( errorType == DioErrorType.CANCEL){
//
//    }
//    success = json['success'];
//    message = json['message'];
//    status = json['status'];
  }
  BodyAPIModel.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        data =  json['data']==null?null: CheckInput.fromJson(json['data']),
        message = json['message'],
        status = json['status'];


  @override
  String toString() {

    return "STR OUTPUT {success: ${success} message ${message}";
  }
}

//todo very important class //////////////////////////////////////////////
class CheckInput {
  static T fromJson<T, k>(dynamic json) {
    if (json is Iterable) {
      print("(json is Iterable) = ");
    } else if (T == Object) {
      return null;
    } else {
      throw Exception("Unknown class");
    }
  }

  static List<K> _fromJsonList<K>(List jsonList) {
    if (jsonList == null) {
      return null;
    }

    List<K> output = [];

    for (Map<String, dynamic> json in jsonList) {
      output.add(fromJson(json));
    }

    return output;
  }
}
