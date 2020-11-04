part of 'setting_bloc.dart';

abstract class SettingState with EquatableMixin {
  Setting setting;
  DateTime dateTime;

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

class ReadySettingState extends SettingState {
  @override
  SettingState copy() => ReadySettingState()
    ..setting = setting
    ..dateTime = dateTime;
}
