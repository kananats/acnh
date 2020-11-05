part of 'fish_bloc.dart';

abstract class FishState with EquatableMixin {
  FishFilterCondition condition;

  @override
  List<Object> get props => [condition];
}

class InitialFishState extends FishState {}

class DownloadingFishState extends FishState {
  int count;
  int total;

  @override
  List<Object> get props => [condition, count, total];

  String get downloadingString => count != null && total != null
      ? "Downloading $count of $total"
      : "Downloading...";
}

class ReadyFishState extends FishState {
  List<Fish> fishs;
  List<bool> isVisibles;

  @override
  List<Object> get props => [fishs, isVisibles];
}

class FailedFishState extends FishState {
  String error;
}
