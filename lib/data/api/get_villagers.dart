part of 'api.dart';

class GetVillagers with ApiMixin<List<Villager>> {
  @override
  String get path => "/v1/villagers";

  @override
  List<Villager> fromJson(json) => Map<String, Map<String, dynamic>>.from(json)
      .values
      .map((element) => Villager.fromJson(element))
      .toList();
}
