// ignore_for_file: non_constant_identifier_names

part of 'dao.dart';

class SeaDao with Dao<Sea> {
  @override
  String get tableName => "seas";

  @override
  List<String> get ignoredProps => [
        SeaColumns.image_path,
        SeaColumns.icon_path,
        SeaColumns.is_caught,
        SeaColumns.is_donated,
      ];

  @override
  Sea fromMap(Map<String, dynamic> map) => Sea()
    ..id = map[SeaColumns.id]
    ..fileName = map[SeaColumns.file_name]
    ..name = Name.fromJson(json.decode(map[SeaColumns.name]))
    ..availability =
        Availability.fromJson(json.decode(map[SeaColumns.availability]))
    ..speed = map[SeaColumns.speed]
    ..shadow = map[SeaColumns.shadow]
    ..price = map[SeaColumns.price]
    ..catchPhrase = map[SeaColumns.catch_phrase]
    ..museumPhrase = map[SeaColumns.museum_phrase]
    ..imageUri = map[SeaColumns.image_uri]
    ..iconUri = map[SeaColumns.icon_uri]
    ..imagePath = map[SeaColumns.image_path]
    ..iconPath = map[SeaColumns.icon_path]
    ..isCaught = map[SeaColumns.is_caught] == 1
    ..isDonated = map[SeaColumns.is_donated] == 1;

  @override
  Map<String, dynamic> toMap(Sea data) => {
        SeaColumns.id: data.id,
        SeaColumns.file_name: data.fileName,
        SeaColumns.name: json.encode(data.name.toJson()),
        SeaColumns.availability: json.encode(data.availability.toJson()),
        SeaColumns.speed: data.speed,
        SeaColumns.shadow: data.shadow,
        SeaColumns.price: data.price,
        SeaColumns.catch_phrase: data.catchPhrase,
        SeaColumns.museum_phrase: data.museumPhrase,
        SeaColumns.image_uri: data.imageUri,
        SeaColumns.icon_uri: data.iconUri,
        SeaColumns.image_path: data.imagePath,
        SeaColumns.icon_path: data.iconPath,
        SeaColumns.is_caught: data.isCaught == true ? 1 : 0,
        SeaColumns.is_donated: data.isDonated == true ? 1 : 0,
      };
}

class SeaColumns {
  static final id = "id";
  static final file_name = "file_name";
  static final name = "name";
  static final availability = "availability";
  static final speed = "speed";
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
