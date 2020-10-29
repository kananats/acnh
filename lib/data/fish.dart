class Fish {
  int id;
  String name;

  String imageUri;
  String iconUri;

  Fish({this.id, this.name, this.imageUri, this.iconUri});

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image_uri": imageUri,
      };

  factory Fish.fromMap(Map<String, dynamic> map) => Fish(
        id: map["id"],
        name: map["name"],
        imageUri: map["image_uri"],
      );

  factory Fish.fromJson(Map<String, dynamic> json) => Fish(
        id: json["id"],
        name: json["name"]["name-USen"],
        imageUri: json["image_uri"],
        iconUri: json["icon_uri"],
      );
}
