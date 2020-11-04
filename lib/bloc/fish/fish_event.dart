part of 'fish_bloc.dart';

abstract class FishEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class DownloadFishEvent extends FishEvent {
  int count;
  int total;

  @override
  List<Object> get props => [count, total];
}

class ViewFishEvent extends FishEvent {}

class UpdateFishEvent extends FishEvent {
  Fish fish;

  UpdateFishEvent(this.fish);
}

class SetFilterConditionFishEvent extends FishEvent {
  FishFilterCondition condition;

  SetFilterConditionFishEvent(this.condition);
}
