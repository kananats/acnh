import 'package:acnh/fish/fish.dart';
import 'package:equatable/equatable.dart';

abstract class FishState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class InitialFishState extends FishState {}

class FailedFishState extends FishState {}

class SuccessFishState extends FishState {
  List<Fish> fishs;

  @override
  List<Object> get props => [fishs];
}
