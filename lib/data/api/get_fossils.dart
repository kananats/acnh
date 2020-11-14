part of 'api.dart';

class GetFossils with ApiMixin<List<Fossil>> {
  @override
  String get path => "/v1/fossils";

  @override
  List<Fossil> fromJson(json) => Map<String, Map<String, dynamic>>.from(json)
      .values
      .mapIndexed((index, element) => Fossil.fromJson(element)..id = index)
      .toList();
}
