part of 'fossil_bloc.dart';

abstract class FossilState with EquatableMixin {
  FossilFilterCondition condition;

  @override
  List<Object> get props => [condition];
}

class InitialFossilState extends FossilState {}

class ReadyFossilState extends FossilState {
  List<Fossil> fossils;
  List<bool> isVisibles;

  @override
  List<Object> get props => [fossils, isVisibles];
}

class DownloadingFossilState extends FossilState {
  @override
  List<Object> get props => [condition];

  String get progressString => "Downloading...";
}

class FailedFossilState extends FossilState {
  String error;
}
