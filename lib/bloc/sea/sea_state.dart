part of 'sea_bloc.dart';

abstract class SeaState with EquatableMixin {
  SeaFilterCondition condition;

  @override
  List<Object> get props => [condition];
}

class InitialSeaState extends SeaState {}

class ReadySeaState extends SeaState {
  List<Sea> seas;
  List<bool> isVisibles;

  @override
  List<Object> get props => [seas, isVisibles];
}

class DownloadingSeaState extends SeaState {
  @override
  List<Object> get props => [condition];

  String get progressString => "Downloading...";
}

class FailedSeaState extends SeaState {
  String error;
}
