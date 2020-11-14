import 'package:acnh/dto/name.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fossil.g.dart';

@JsonSerializable(explicitToJson: true)
class Fossil with EquatableMixin {
  @JsonKey(ignore: true)
  int id;

  @JsonKey(name: "file-name")
  String fileName;

  Name name;
  int price;

  @JsonKey(name: "museum-phrase")
  String museumPhrase;

  @JsonKey(name: "image_uri")
  String imageUri;

  String imagePath;

  bool isDonated;

  static Fossil fromJson(Map<String, dynamic> json) => _$FossilFromJson(json);

  Map<String, dynamic> toJson() => _$FossilToJson(this);

  @override
  List<Object> get props => [fileName];
}
