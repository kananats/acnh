import 'package:acnh/data/request.dart';
import 'package:acnh/dto/fish.dart';

class GetFishs with RequestMixin<List<Fish>> {
  @override
  String get path => "/v1/fish";

  @override
  List<Fish> fromJson(json) => Map<String, Map<String, dynamic>>.from(json)
      .values
      .map((element) => Fish.fromJson(element))
      .toList();
}
