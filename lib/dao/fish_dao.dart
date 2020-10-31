import 'dart:convert';

import 'package:acnh/dao/dao.dart';
import 'package:acnh/dto/fish.dart';

class FishDao with Dao<Fish> {
  @override
  String get tableName => "fishs";

  @override
  List<String> get ignoredProps =>
      ["image_path", "icon_path", "is_caught", "is_donated"];

  @override
  Fish fromMap(Map<String, dynamic> map) => Fish(
        id: map["id"],
        name: map["name"],
        price: map["price"],
        location: map["location"],
        shadow: map["shadow"],
        monthArrayNorthern:
            json.decode(map["month_array_northern"]).cast<int>(),
        imageUri: map["image_uri"],
        iconUri: map["icon_uri"],
        imagePath: map["image_path"],
        iconPath: map["icon_path"],
        isCaught: map["is_caught"] == 1,
        isDonated: map["is_donated"] == 1,
      );

  @override
  Map<String, dynamic> toMap(Fish data) => {
        "id": data.id,
        "name": data.name,
        "location": data.location,
        "shadow": data.shadow,
        "price": data.price,
        "month_array_northern": data.monthArrayNorthern.toString(),
        "image_uri": data.imageUri,
        "icon_uri": data.iconUri,
        "image_path": data.imagePath,
        "icon_path": data.iconPath,
        "is_caught": data.isCaught ? 1 : 0,
        "is_donated": data.isDonated ? 1 : 0,
      };
}
