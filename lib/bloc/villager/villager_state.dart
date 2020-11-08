part of 'villager_bloc.dart';

abstract class VillagerState with EquatableMixin {
  VillagerFilterCondition condition;

  @override
  List<Object> get props => [condition];
}

class InitialVillagerState extends VillagerState {}

class ReadyVillagerState extends VillagerState {
  List<Villager> villagers;
  List<bool> isVisibles;

  @override
  List<Object> get props => [villagers, isVisibles];
}

class DownloadingVillagerState extends VillagerState {
  @override
  List<Object> get props => [condition];

  String get progressString => "Downloading...";
}

class FailedVillagerState extends VillagerState {
  String error;
}
