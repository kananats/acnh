part of 'art_bloc.dart';

abstract class ArtState with EquatableMixin {
  ArtFilterCondition condition;

  @override
  List<Object> get props => [condition];
}

class InitialArtState extends ArtState {}

class ReadyArtState extends ArtState {
  List<Art> arts;
  List<bool> isVisibles;

  @override
  List<Object> get props => [arts, isVisibles];
}

class DownloadingArtState extends ArtState {
  @override
  List<Object> get props => [condition];

  String get progressString => "Downloading...";
}

class FailedArtState extends ArtState {
  String error;
}
