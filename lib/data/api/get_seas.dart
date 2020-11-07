part of 'api.dart';

class GetSeas with ApiMixin<List<Sea>> {
  @override
  String get path => "/v1/sea";

  @override
  List<Sea> fromJson(json) => Map<String, Map<String, dynamic>>.from(json)
      .values
      .map((element) => Sea.fromJson(element))
      .toList();
}
