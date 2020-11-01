import 'package:equatable/equatable.dart';

abstract class TimeEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class TickTimeEvent extends TimeEvent {}

class PauseTimeEvent extends TimeEvent {
  DateTime dateTime;
}

class PlayTimeEvent extends TimeEvent {}

class ResetTimeEvent extends TimeEvent {}
