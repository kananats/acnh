// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'name.g.dart';

@JsonSerializable(explicitToJson: true)
class Name {
  @JsonKey(name: "name-USen")
  String USen;

  @JsonKey(name: "name-EUen")
  String EUen;

  @JsonKey(name: "name-EUde")
  String EUde;

  @JsonKey(name: "name-EUes")
  String EUes;

  @JsonKey(name: "name-USes")
  String USes;

  @JsonKey(name: "name-EUfr")
  String EUfr;

  @JsonKey(name: "name-USfr")
  String USfr;

  @JsonKey(name: "name-EUit")
  String EUit;

  @JsonKey(name: "name-EUnl")
  String EUnl;

  @JsonKey(name: "name-CNzh")
  String CNzh;

  @JsonKey(name: "name-TWzh")
  String TWzh;

  @JsonKey(name: "name-JPja")
  String JPja;

  @JsonKey(name: "name-KRko")
  String KRko;

  @JsonKey(name: "name-EUru")
  String EUru;

  static Name fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);

  String get name => USen; // TODO
}
