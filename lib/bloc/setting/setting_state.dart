import 'package:equatable/equatable.dart';

abstract class SettingState with EquatableMixin {
  DateTime dateTime = DateTime.now();

  @override
  List<Object> get props => [dateTime];
}

class InitialSettingState extends SettingState {}

class TimeNowSettingState extends SettingState {}

class TimePlaySettingState extends SettingState {}

class TimePauseSettingState extends SettingState {}
