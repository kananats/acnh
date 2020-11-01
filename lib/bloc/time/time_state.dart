import 'package:equatable/equatable.dart';

abstract class TimeState with EquatableMixin {
  DateTime dateTime = DateTime.now();

  @override
  List<Object> get props => [dateTime];
}

class NowTimeState extends TimeState {}

class PlayTimeState extends TimeState {}

class PauseTimeState extends TimeState {}
