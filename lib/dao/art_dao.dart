// ignore_for_file: non_constant_identifier_names

part of 'dao.dart';

class ArtDao with Dao<Art> {
  @override
  String get tableName => "arts";

  @override
  List<String> get ignoredProps => [
        ArtColumns.image_path,
        ArtColumns.is_donated,
      ];

  @override
  Art fromMap(Map<String, dynamic> map) => Art()
    ..id = map[ArtColumns.id]
    ..fileName = map[ArtColumns.file_name]
    ..name = Name.fromJson(json.decode(map[ArtColumns.name]))
    ..hasFake = map[ArtColumns.has_fake] == 1
    ..buyPrice = map[ArtColumns.buy_price]
    ..sellPrice = map[ArtColumns.sell_price]
    ..imageUri = map[ArtColumns.image_uri]
    ..imagePath = map[ArtColumns.image_path]
    ..museumDesc = map[ArtColumns.museum_desc]
    ..isDonated = map[ArtColumns.is_donated] == 1;

  @override
  Map<String, dynamic> toMap(Art data) => {
        ArtColumns.id: data.id,
        ArtColumns.file_name: data.fileName,
        ArtColumns.name: json.encode(data.name.toJson()),
        ArtColumns.has_fake: data.hasFake == true ? 1 : 0,
        ArtColumns.buy_price: data.buyPrice,
        ArtColumns.sell_price: data.sellPrice,
        ArtColumns.image_uri: data.imageUri,
        ArtColumns.image_path: data.imagePath,
        ArtColumns.museum_desc: data.museumDesc,
        ArtColumns.is_donated: data.isDonated == true ? 1 : 0,
      };
}

class ArtColumns {
  static final id = "id";
  static final file_name = "file_name";
  static final name = "name";
  static final has_fake = "has_fake";
  static final buy_price = "buy_price";
  static final sell_price = "sell_price";
  static final image_uri = "image_uri";
  static final image_path = "image_path";
  static final museum_desc = "museum_desc";
  static final is_donated = "is_donated";
}
