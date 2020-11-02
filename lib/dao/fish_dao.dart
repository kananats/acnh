// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:acnh/dao/dao.dart';
import 'package:acnh/dto/availability.dart';
import 'package:acnh/dto/fish.dart';
import 'package:acnh/dto/name.dart';

class FishDao with Dao<Fish> {
  @override
  String get tableName => "fishs";

  @override
  List<String> get ignoredProps => [
        _Columns.image_path,
        _Columns.icon_path,
        _Columns.is_caught,
        _Columns.is_donated,
      ];

  @override
  Fish fromMap(Map<String, dynamic> map) => Fish()
    ..id = map[_Columns.id]
    ..fileName = map[_Columns.file_name]
    ..name = Name.fromJson(json.decode(map[_Columns.name]))
    ..availability =
        Availability.fromJson(json.decode(map[_Columns.availability]))
    ..shadow = map[_Columns.shadow]
    ..price = map[_Columns.price]
    ..catchPhrase = map[_Columns.catch_phrase]
    ..museumPhrase = map[_Columns.museum_phrase]
    ..imageUri = map[_Columns.image_uri]
    ..iconUri = map[_Columns.icon_uri]
    ..imagePath = map[_Columns.image_path]
    ..iconPath = map[_Columns.icon_path]
    ..isCaught = map[_Columns.is_caught] == 1
    ..isDonated = map[_Columns.is_donated] == 1;

  @override
  Map<String, dynamic> toMap(Fish data) => {
        _Columns.id: data.id,
        _Columns.file_name: data.fileName,
        _Columns.name: json.encode(data.name.toJson()),
        _Columns.availability: json.encode(data.availability.toJson()),
        _Columns.shadow: data.shadow,
        _Columns.price: data.price,
        _Columns.catch_phrase: data.catchPhrase,
        _Columns.museum_phrase: data.museumPhrase,
        _Columns.image_uri: data.imageUri,
        _Columns.icon_uri: data.iconUri,
        _Columns.image_path: data.imagePath,
        _Columns.icon_path: data.iconPath,
        _Columns.is_caught: 1, //data.isCaught ? 1 : 0,
        _Columns.is_donated: 1, //data.isDonated ? 1 : 0,
      };
}

class _Columns {
  static final id = "id";
  static final file_name = "file_name";
  static final name = "name";
  static final availability = "availability";
  static final shadow = "shadow";
  static final price = "price";
  static final catch_phrase = "catch_phrase";
  static final museum_phrase = "museum_phrase";
  static final image_uri = "image_uri";
  static final icon_uri = "icon_uri";
  static final image_path = "image_path";
  static final icon_path = "icon_path";
  static final is_caught = "is_caught";
  static final is_donated = "is_donated";
}
