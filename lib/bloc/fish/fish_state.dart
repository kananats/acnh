part of 'fish_bloc.dart';

abstract class FishState with EquatableMixin {
  FishFilterCondition condition;

  @override
  List<Object> get props => [condition];
}

class InitialFishState extends FishState {}

class ReadyFishState extends FishState {
  List<Fish> fishs;
  List<bool> isVisibles;

  @override
  List<Object> get props => [fishs, isVisibles];
}

class DownloadingFishState extends FishState {
  @override
  List<Object> get props => [condition];

  String get progressString => "Downloading...";
}

class FailedFishState extends FishState {
  String error;
}
