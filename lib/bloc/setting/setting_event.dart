part of 'setting_bloc.dart';

abstract class SettingEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class TickSettingEvent extends SettingEvent {
  DateTime dateTime;

  @override
  List<Object> get props => [dateTime];
}

class SetLanguageSettingEvent extends SettingEvent {
  LanguageEnum language;

  @override
  List<Object> get props => [language];
}

class SetDateSettingEvent extends SettingEvent {
  DateTime date;

  @override
  List<Object> get props => [date];
}

class SetTimeSettingEvent extends SettingEvent {
  TimeOfDay time;

  @override
  List<Object> get props => [time];
}

class ToggleFreezeSettingEvent extends SettingEvent {}

class ResetTimeSettingEvent extends SettingEvent {}
