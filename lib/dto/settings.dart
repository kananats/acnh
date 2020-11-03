import 'package:acnh/dto/language_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

@JsonSerializable(explicitToJson: true)
class Setting {
  LanguageEnum language;

  Duration offset;
  DateTime dateTime;

  static Setting fromJson(Map<String, dynamic> json) => _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);
}
