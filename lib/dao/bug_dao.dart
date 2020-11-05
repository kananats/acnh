// ignore_for_file: non_constant_identifier_names

part of 'dao.dart';

class BugDao with Dao<Bug> {
  @override
  String get tableName => "bugs";

  @override
  List<String> get ignoredProps => [
        BugColumns.image_path,
        BugColumns.icon_path,
        BugColumns.is_caught,
        BugColumns.is_donated,
      ];

  @override
  Bug fromMap(Map<String, dynamic> map) => Bug()
    ..id = map[BugColumns.id]
    ..fileName = map[BugColumns.file_name]
    ..name = Name.fromJson(json.decode(map[BugColumns.name]))
    ..availability =
        Availability.fromJson(json.decode(map[BugColumns.availability]))
    ..price = map[BugColumns.price]
    ..catchPhrase = map[BugColumns.catch_phrase]
    ..museumPhrase = map[BugColumns.museum_phrase]
    ..imageUri = map[BugColumns.image_uri]
    ..iconUri = map[BugColumns.icon_uri]
    ..imagePath = map[BugColumns.image_path]
    ..iconPath = map[BugColumns.icon_path]
    ..isCaught = map[BugColumns.is_caught] == 1
    ..isDonated = map[BugColumns.is_donated] == 1;

  @override
  Map<String, dynamic> toMap(Bug data) => {
        BugColumns.id: data.id,
        BugColumns.file_name: data.fileName,
        BugColumns.name: json.encode(data.name.toJson()),
        BugColumns.availability: json.encode(data.availability.toJson()),
        BugColumns.price: data.price,
        BugColumns.catch_phrase: data.catchPhrase,
        BugColumns.museum_phrase: data.museumPhrase,
        BugColumns.image_uri: data.imageUri,
        BugColumns.icon_uri: data.iconUri,
        BugColumns.image_path: data.imagePath,
        BugColumns.icon_path: data.iconPath,
        BugColumns.is_caught: data.isCaught == true ? 1 : 0,
        BugColumns.is_donated: data.isDonated == true ? 1 : 0,
      };
}

class BugColumns {
  static final id = "id";
  static final file_name = "file_name";
  static final name = "name";
  static final availability = "availability";
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
