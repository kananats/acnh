import 'package:acnh/dto/fish.dart';
import 'package:acnh/ui/fish/fish_filter_condition.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

class UpdateFishEvent extends FishEvent {
  Fish fish;

  UpdateFishEvent({@required this.fish});
}

class FilterFishEvent extends FishEvent {
  FishFilterCondition condition;

  FilterFishEvent({@required this.condition});
}
