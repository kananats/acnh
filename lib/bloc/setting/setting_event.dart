import 'package:equatable/equatable.dart';

abstract class SettingEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class InitializeSettingEvent extends SettingEvent {}

class TimeTickSettingEvent extends SettingEvent {}

class TimePauseSettingEvent extends SettingEvent {
  DateTime dateTime;
}

class TimePlaySettingEvent extends SettingEvent {}

class TimeResetSettingEvent extends SettingEvent {}
