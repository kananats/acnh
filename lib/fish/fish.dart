import 'package:equatable/equatable.dart';

class Fish with EquatableMixin {
  int id;
  String name;

  String imageUri;
  String iconUri;

  bool isCaught;
  bool isDonated;

  Fish({
    this.id,
    this.name,
    this.imageUri,
    this.iconUri,
    this.isCaught = false,
    this.isDonated = false,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image_uri": imageUri,
        "icon_uri": iconUri,
        "is_caught": isCaught ? 1 : 0,
        "is_donated": isDonated ? 1 : 0,
      };

  factory Fish.fromMap(Map<String, dynamic> map) => Fish(
        id: map["id"],
        name: map["name"],
        imageUri: map["image_uri"],
        iconUri: map["icon_uri"],
        isCaught: map["is_caught"] == 1,
        isDonated: map["is_donated"] == 1,
      );

  factory Fish.fromJson(Map<String, dynamic> json) => Fish(
        id: json["id"],
        name: json["name"]["name-USen"],
        imageUri: json["image_uri"],
        iconUri: json["icon_uri"],
      );
}
