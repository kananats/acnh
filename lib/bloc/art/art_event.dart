part of 'art_bloc.dart';

abstract class ArtEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class FindArtEvent extends ArtEvent {}

class UpdateArtEvent extends ArtEvent {
  Art art;

  UpdateArtEvent(this.art);

  @override
  List<Object> get props => [art];
}

class SetConditionArtEvent extends ArtEvent {
  ArtFilterCondition condition;

  SetConditionArtEvent(this.condition);

  @override
  List<Object> get props => [condition];
}

class DownloadArtEvent extends ArtEvent {
  int count;
  int total;

  @override
  List<Object> get props => [count, total];
}
