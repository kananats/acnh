part of 'villager_bloc.dart';

abstract class VillagerEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class FindVillagerEvent extends VillagerEvent {}

class UpdateVillagerEvent extends VillagerEvent {
  Villager villager;

  UpdateVillagerEvent(this.villager);

  @override
  List<Object> get props => [villager];
}

class SetConditionVillagerEvent extends VillagerEvent {
  VillagerFilterCondition condition;

  SetConditionVillagerEvent(this.condition);

  @override
  List<Object> get props => [condition];
}

class DownloadVillagerEvent extends VillagerEvent {
  int count;
  int total;

  @override
  List<Object> get props => [count, total];
}
