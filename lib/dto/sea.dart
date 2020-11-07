import 'package:acnh/dto/availability.dart';
import 'package:acnh/dto/name.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sea.g.dart';

@JsonSerializable(explicitToJson: true)
class Sea with EquatableMixin {
  int id;

  @JsonKey(name: "file-name")
  String fileName;

  Name name;
  Availability availability;
  String speed;
  String shadow;

  int price;

  @JsonKey(name: "catch-phrase")
  String catchPhrase;

  @JsonKey(name: "museum-phrase")
  String museumPhrase;

  @JsonKey(name: "image_uri")
  String imageUri;

  @JsonKey(name: "icon_uri")
  String iconUri;

  String imagePath;
  String iconPath;

  bool isCaught;
  bool isDonated;

  static Sea fromJson(Map<String, dynamic> json) => _$SeaFromJson(json);

  Map<String, dynamic> toJson() => _$SeaToJson(this);

  @override
  List<Object> get props => [id];
}
