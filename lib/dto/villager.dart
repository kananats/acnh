import 'package:acnh/dto/name.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'villager.g.dart';

@JsonSerializable(explicitToJson: true)
class Villager with EquatableMixin {
  int id;

  @JsonKey(name: "file-name")
  String fileName;

  Name name;
  String personality;
  String birthday;
  String species;
  String gender;

  @JsonKey(name: "catch-phrase")
  String catchPhrase;

  @JsonKey(name: "image_uri")
  String imageUri;

  @JsonKey(name: "icon_uri")
  String iconUri;

  String imagePath;
  String iconPath;

  bool isResident;
  bool isFavorite;

  static Villager fromJson(Map<String, dynamic> json) =>
      _$VillagerFromJson(json);

  Map<String, dynamic> toJson() => _$VillagerToJson(this);

  @override
  List<Object> get props => [id];
}
