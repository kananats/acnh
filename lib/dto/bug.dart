import 'package:acnh/dto/availability.dart';
import 'package:acnh/dto/name.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bug.g.dart';

@JsonSerializable(explicitToJson: true)
class Bug with EquatableMixin {
  int id;

  @JsonKey(name: "file-name")
  String fileName;

  Name name;
  Availability availability;
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

  static Bug fromJson(Map<String, dynamic> json) => _$BugFromJson(json);

  Map<String, dynamic> toJson() => _$BugToJson(this);

  @override
  List<Object> get props => [id];
}
