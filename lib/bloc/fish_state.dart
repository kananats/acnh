import 'package:acnh/dto/fish.dart';
import 'package:acnh/ui/fish/fish_filter_condition.dart';
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
  List<bool> isVisibles;

  DateTime lastUpdated; // TODO

  @override
  List<Object> get props => [fishs, isVisibles];
}

class FailedFishState extends FishState {
  String error;
}
