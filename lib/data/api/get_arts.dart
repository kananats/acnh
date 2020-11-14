part of 'api.dart';

class GetArts with ApiMixin<List<Art>> {
  @override
  String get path => "/v1/art";

  @override
  List<Art> fromJson(json) => Map<String, Map<String, dynamic>>.from(json)
      .values
      .map((element) => Art.fromJson(element))
      .toList();
}
