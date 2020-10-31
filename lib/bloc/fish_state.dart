import 'package:acnh/dto/fish.dart';
import 'package:equatable/equatable.dart';

abstract class FishState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class InitialFishState extends FishState {}

class NotDownloadedFishState extends FishState {}

class DownloadingFishState extends FishState {
  int count;
  int total;

  @override
  List<Object> get props => [count, total];

  String get downloadingString => count != null && total != null
      ? "Downloading $count of $total"
      : "Downloading...";
}

class SuccessFishState extends FishState {
  List<Fish> fishs;
  DateTime lastUpdated;

  @override
  List<Object> get props => [fishs];
}

class FailedFishState extends FishState {
  String error;
}
