import 'package:acnh/dto/name.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'art.g.dart';

@JsonSerializable(explicitToJson: true)
class Art with EquatableMixin {
  int id;

  @JsonKey(name: "file-name")
  String fileName;

  Name name;

  bool hasFake;

  @JsonKey(name: "buy-price")
  int buyPrice;

  @JsonKey(name: "sell-price")
  int sellPrice;

  @JsonKey(name: "image_uri")
  String imageUri;

  String imagePath;

  @JsonKey(name: "museum-desc")
  String museumDesc;

  bool isDonated;

  static Art fromJson(Map<String, dynamic> json) => _$ArtFromJson(json);

  Map<String, dynamic> toJson() => _$ArtToJson(this);

  @override
  List<Object> get props => [id];
}
