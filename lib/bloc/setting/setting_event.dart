import 'package:acnh/dto/language_enum.dart';
import 'package:equatable/equatable.dart';

abstract class SettingEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class InitializeSettingEvent extends SettingEvent {}

class SetLanguageSettingEvent extends SettingEvent {
  LanguageEnum language;

  @override
  List<Object> get props => [language];
}

class TimeTickSettingEvent extends SettingEvent {}

class TimePauseSettingEvent extends SettingEvent {
  DateTime dateTime;

  @override
  List<Object> get props => [dateTime];
}

class TimePlaySettingEvent extends SettingEvent {}

class TimeResetSettingEvent extends SettingEvent {}
