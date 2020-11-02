import 'package:json_annotation/json_annotation.dart';

part 'name.g.dart';

@JsonSerializable(explicitToJson: true)
class Name {
  @JsonKey(name: "name-USen")
  // ignore: non_constant_identifier_names
  String USen;

  @JsonKey(name: "name-EUen")
  // ignore: non_constant_identifier_names
  String EUen;

  @JsonKey(name: "name-EUde")
  // ignore: non_constant_identifier_names
  String EUde;

  @JsonKey(name: "name-EUes")
  // ignore: non_constant_identifier_names
  String EUes;

  @JsonKey(name: "name-USes")
  // ignore: non_constant_identifier_names
  String USes;

  @JsonKey(name: "name-EUfr")
  // ignore: non_constant_identifier_names
  String EUfr;

  @JsonKey(name: "name-USfr")
  // ignore: non_constant_identifier_names
  String USfr;

  @JsonKey(name: "name-EUit")
  // ignore: non_constant_identifier_names
  String EUit;

  @JsonKey(name: "name-EUnl")
  // ignore: non_constant_identifier_names
  String EUnl;

  @JsonKey(name: "name-CNzh")
  // ignore: non_constant_identifier_names
  String CNzh;

  @JsonKey(name: "name-TWzh")
  // ignore: non_constant_identifier_names
  String TWzh;

  @JsonKey(name: "name-JPja")
  // ignore: non_constant_identifier_names
  String JPja;

  @JsonKey(name: "name-KRko")
  // ignore: non_constant_identifier_names
  String KRko;

  @JsonKey(name: "name-EUru")
  // ignore: non_constant_identifier_names
  String EUru;

  static Name fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);

  String get name => USen; // TODO
}
