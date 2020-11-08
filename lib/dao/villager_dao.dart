// ignore_for_file: non_constant_identifier_names

part of 'dao.dart';

class VillagerDao with Dao<Villager> {
  @override
  String get tableName => "villagers";

  @override
  List<String> get ignoredProps => [
        VillagerColumns.image_path,
        VillagerColumns.icon_path,
        VillagerColumns.is_resident,
        VillagerColumns.is_favorite,
      ];

  @override
  Villager fromMap(Map<String, dynamic> map) => Villager()
    ..id = map[VillagerColumns.id]
    ..fileName = map[VillagerColumns.file_name]
    ..name = Name.fromJson(json.decode(map[VillagerColumns.name]))
    ..personality = map[VillagerColumns.personality]
    ..birthday = map[VillagerColumns.birthday]
    ..species = map[VillagerColumns.species]
    ..gender = map[VillagerColumns.gender]
    ..catchPhrase = map[VillagerColumns.catch_phrase]
    ..imageUri = map[VillagerColumns.image_uri]
    ..iconUri = map[VillagerColumns.icon_uri]
    ..imagePath = map[VillagerColumns.image_path]
    ..iconPath = map[VillagerColumns.icon_path]
    ..isResident = map[VillagerColumns.is_resident] == 1
    ..isFavorite = map[VillagerColumns.is_favorite] == 1;

  @override
  Map<String, dynamic> toMap(Villager data) => {
        VillagerColumns.id: data.id,
        VillagerColumns.file_name: data.fileName,
        VillagerColumns.name: json.encode(data.name.toJson()),
        VillagerColumns.personality: data.personality,
        VillagerColumns.birthday: data.birthday,
        VillagerColumns.species: data.species,
        VillagerColumns.gender: data.gender,
        VillagerColumns.catch_phrase: data.catchPhrase,
        VillagerColumns.image_uri: data.imageUri,
        VillagerColumns.icon_uri: data.iconUri,
        VillagerColumns.image_path: data.imagePath,
        VillagerColumns.icon_path: data.iconPath,
        VillagerColumns.is_resident: data.isResident == true ? 1 : 0,
        VillagerColumns.is_favorite: data.isFavorite == true ? 1 : 0,
      };
}

class VillagerColumns {
  static final id = "id";
  static final file_name = "file_name";
  static final name = "name";
  static final personality = "personality";
  static final birthday = "birthday";
  static final species = "species";
  static final gender = "gender";
  static final catch_phrase = "catch_phrase";
  static final image_uri = "image_uri";
  static final icon_uri = "icon_uri";
  static final image_path = "image_path";
  static final icon_path = "icon_path";
  static final is_resident = "is_resident";
  static final is_favorite = "is_favorite";
}
