// ignore_for_file: non_constant_identifier_names

part of 'dao.dart';

class FishDao with Dao<Fish> {
  @override
  String get tableName => "fishs";

  @override
  List<String> get ignoredProps => [
        FishColumns.image_path,
        FishColumns.icon_path,
        FishColumns.is_caught,
        FishColumns.is_donated,
      ];

  @override
  Fish fromMap(Map<String, dynamic> map) => Fish()
    ..id = map[FishColumns.id]
    ..fileName = map[FishColumns.file_name]
    ..name = Name.fromJson(json.decode(map[FishColumns.name]))
    ..availability =
        Availability.fromJson(json.decode(map[FishColumns.availability]))
    ..shadow = map[FishColumns.shadow]
    ..price = map[FishColumns.price]
    ..catchPhrase = map[FishColumns.catch_phrase]
    ..museumPhrase = map[FishColumns.museum_phrase]
    ..imageUri = map[FishColumns.image_uri]
    ..iconUri = map[FishColumns.icon_uri]
    ..imagePath = map[FishColumns.image_path]
    ..iconPath = map[FishColumns.icon_path]
    ..isCaught = map[FishColumns.is_caught] == 1
    ..isDonated = map[FishColumns.is_donated] == 1;

  @override
  Map<String, dynamic> toMap(Fish data) => {
        FishColumns.id: data.id,
        FishColumns.file_name: data.fileName,
        FishColumns.name: json.encode(data.name.toJson()),
        FishColumns.availability: json.encode(data.availability.toJson()),
        FishColumns.shadow: data.shadow,
        FishColumns.price: data.price,
        FishColumns.catch_phrase: data.catchPhrase,
        FishColumns.museum_phrase: data.museumPhrase,
        FishColumns.image_uri: data.imageUri,
        FishColumns.icon_uri: data.iconUri,
        FishColumns.image_path: data.imagePath,
        FishColumns.icon_path: data.iconPath,
        FishColumns.is_caught: data.isCaught == true ? 1 : 0,
        FishColumns.is_donated: data.isDonated == true ? 1 : 0,
      };
}

class FishColumns {
  static final id = "id";
  static final file_name = "file_name";
  static final name = "name";
  static final availability = "availability";
  static final shadow = "shadow";
  static final price = "price";
  static final catch_phrase = "catch_phrase";
  static final museum_phrase = "museum_phrase";
  static final image_uri = "image_uri";
  static final icon_uri = "icon_uri";
  static final image_path = "image_path";
  static final icon_path = "icon_path";
  static final is_caught = "is_caught";
  static final is_donated = "is_donated";
}
