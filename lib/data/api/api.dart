import 'dart:async';
import 'dart:convert';

import 'package:acnh/dto/art.dart';
import 'package:acnh/util/iterable_extension.dart';

import 'package:acnh/error/error.dart';
import 'package:acnh/dto/villager.dart';
import 'package:acnh/dto/fish.dart';
import 'package:acnh/dto/bug.dart';
import 'package:acnh/dto/sea.dart';
import 'package:acnh/dto/fossil.dart';
import 'package:dio/dio.dart';

part 'get_villagers.dart';
part 'get_fishs.dart';
part 'get_bugs.dart';
part 'get_seas.dart';
part 'get_fossils.dart';
part 'get_arts.dart';

mixin ApiMixin<T> {
  String get baseUrl => "http://acnhapi.com";
  String get path;

  T fromJson(dynamic json);

  Future<T> execute() async {
    Response<String> response;
    try {
      response = await Dio().get(baseUrl + path);
    } catch (error) {
      throw NetworkError();
    }
    if (response.statusCode != 200) throw InvalidStatusCodeNetworkError();

    var _json = json.decode(response.data);
    if (_json == null) throw DecodeNetworkError();

    return fromJson(_json);
  }
}
