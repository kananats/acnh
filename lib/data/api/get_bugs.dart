part of 'api.dart';

class GetBugs with RequestMixin<List<Bug>> {
  @override
  String get path => "/v1/bugs";

  @override
  List<Bug> fromJson(json) => Map<String, Map<String, dynamic>>.from(json)
      .values
      .map((element) => Bug.fromJson(element))
      .toList();
}
