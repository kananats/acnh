import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:acnh/fish/fish.dart';

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

class GetFish with RequestMixin<List<Fish>> {
  @override
  String get path => "/v1/fish";

  @override
  List<Fish> fromJson(json) => Map<String, Map<String, dynamic>>.from(json)
      .values
      .map((element) => Fish.fromJson(element))
      .toList();
}
