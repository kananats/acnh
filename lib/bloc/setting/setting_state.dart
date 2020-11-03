import 'package:acnh/dto/setting.dart';
import 'package:equatable/equatable.dart';

abstract class SettingState with EquatableMixin {
  Setting setting;
  DateTime dateTime = DateTime.now();

  SettingState copy();

  @override
  List<Object> get props => [setting, dateTime];
}

class InitialSettingState extends SettingState {
  @override
  SettingState copy() => InitialSettingState()
    ..setting = setting
    ..dateTime = dateTime;
}

class TimeNowSettingState extends SettingState {
  @override
  SettingState copy() => InitialSettingState()
    ..setting = setting
    ..dateTime = dateTime;
}

class TimePlaySettingState extends SettingState {
  @override
  SettingState copy() => InitialSettingState()
    ..setting = setting
    ..dateTime = dateTime;
}

class TimePauseSettingState extends SettingState {
  @override
  SettingState copy() => InitialSettingState()
    ..setting = setting
    ..dateTime = dateTime;
}
