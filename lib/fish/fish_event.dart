import 'package:equatable/equatable.dart';

abstract class FishEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class FetchFishEvent extends FishEvent {}
