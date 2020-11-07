part of 'sea_bloc.dart';

abstract class SeaEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class FindSeaEvent extends SeaEvent {}

class UpdateSeaEvent extends SeaEvent {
  Sea sea;

  UpdateSeaEvent(this.sea);

  @override
  List<Object> get props => [sea];
}

class SetConditionSeaEvent extends SeaEvent {
  SeaFilterCondition condition;

  SetConditionSeaEvent(this.condition);

  @override
  List<Object> get props => [condition];
}

class DownloadSeaEvent extends SeaEvent {
  int count;
  int total;

  @override
  List<Object> get props => [count, total];
}
