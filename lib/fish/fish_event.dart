import 'package:equatable/equatable.dart';

abstract class FishEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class InitializeFishEvent extends FishEvent {}

class DownloadFishEvent extends FishEvent {
  int count;
  int total;

  @override
  List<Object> get props => [count, total];
}
