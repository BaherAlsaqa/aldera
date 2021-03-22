import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:aldera/models/BodyAPIModel.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart' as dio;

class APIsData {
  final Dio client;

  var url = "https://aldera.sa/api/v1/";

  APIsData({@required this.client});

  void setAuthorizationHeader(String token) {
    client.options.headers.addAll({"Authorization": token});
  }

  void setLangHeader(String lang) {
    client.options.headers.addAll({"Accept-Language": lang});
  }

  //todo post apis --------------------------------------------

  //todo /////////// get ----------------------------------

}
