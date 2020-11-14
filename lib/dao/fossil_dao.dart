// ignore_for_file: non_constant_identifier_names

part of 'dao.dart';

class FossilDao with Dao<Fossil> {
  @override
  String get tableName => "fossils";

  @override
  List<String> get ignoredProps => [
        FossilColumns.image_path,
        FossilColumns.is_donated,
      ];

  @override
  Fossil fromMap(Map<String, dynamic> map) => Fossil()
    ..id = map[FossilColumns.id]
    ..fileName = map[FossilColumns.file_name]
    ..name = Name.fromJson(json.decode(map[FossilColumns.name]))
    ..price = map[FossilColumns.price]
    ..museumPhrase = map[FossilColumns.museum_phrase]
    ..imageUri = map[FossilColumns.image_uri]
    ..imagePath = map[FossilColumns.image_path]
    ..isDonated = map[FossilColumns.is_donated] == 1;

  @override
  Map<String, dynamic> toMap(Fossil data) => {
        FossilColumns.id: data.id,
        FossilColumns.file_name: data.fileName,
        FossilColumns.name: json.encode(data.name.toJson()),
        FossilColumns.price: data.price,
        FossilColumns.museum_phrase: data.museumPhrase,
        FossilColumns.image_uri: data.imageUri,
        FossilColumns.image_path: data.imagePath,
        FossilColumns.is_donated: data.isDonated == true ? 1 : 0,
      };
}

class FossilColumns {
  static final id = "id";
  static final file_name = "file_name";
  static final name = "name";
  static final price = "price";
  static final museum_phrase = "museum_phrase";
  static final image_uri = "image_uri";
  static final image_path = "image_path";
  static final is_donated = "is_donated";
}
