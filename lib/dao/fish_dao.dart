import 'package:acnh/dao/dao.dart';
import 'package:acnh/ui/fish/fish.dart';

class FishDao with Dao<Fish> {
  @override
  String get tableName => "fishs";

  @override
  Fish fromMap(Map<String, dynamic> map) => Fish(
        id: map["id"],
        name: map["name"],
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
        "image_uri": data.imageUri,
        "icon_uri": data.iconUri,
        "image_path": data.imagePath,
        "icon_path": data.iconPath,
        "is_caught": data.isCaught ? 1 : 0,
        "is_donated": data.isDonated ? 1 : 0,
      };
}
