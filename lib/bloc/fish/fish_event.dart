part of 'fish_bloc.dart';

abstract class FishEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class FindFishEvent extends FishEvent {}

class UpdateFishEvent extends FishEvent {
  Fish fish;

  UpdateFishEvent(this.fish);

  @override
  List<Object> get props => [fish];
}

class SetConditionFishEvent extends FishEvent {
  FishFilterCondition condition;

  SetConditionFishEvent(this.condition);

  @override
  List<Object> get props => [condition];
}

class DownloadFishEvent extends FishEvent {
  int count;
  int total;

  @override
  List<Object> get props => [count, total];
}
