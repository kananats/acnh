part of 'fossil_bloc.dart';

abstract class FossilEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class FindFossilEvent extends FossilEvent {}

class UpdateFossilEvent extends FossilEvent {
  Fossil fossil;

  UpdateFossilEvent(this.fossil);

  @override
  List<Object> get props => [fossil];
}

class SetConditionFossilEvent extends FossilEvent {
  FossilFilterCondition condition;

  SetConditionFossilEvent(this.condition);

  @override
  List<Object> get props => [condition];
}

class DownloadFossilEvent extends FossilEvent {
  int count;
  int total;

  @override
  List<Object> get props => [count, total];
}
