part of 'api.dart';

class GetFishs with RequestMixin<List<Fish>> {
  @override
  String get path => "/v1/fish";

  @override
  List<Fish> fromJson(json) => Map<String, Map<String, dynamic>>.from(json)
      .values
      .map((element) => Fish.fromJson(element))
      .toList();
}
