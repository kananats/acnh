import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

mixin RequestMixin<T> {
  String get baseUrl => "http://acnhapi.com";
  String get path;

  T fromJson(dynamic json);

  Future<T> execute() async {
    Response<String> response = await Dio().get(baseUrl + path);
    if (response.statusCode != 200) throw Exception("Failed to fetch");
    return fromJson(json.decode(response.data));
  }
}
