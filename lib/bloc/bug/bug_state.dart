part of 'bug_bloc.dart';

abstract class BugState with EquatableMixin {
  BugFilterCondition condition;

  @override
  List<Object> get props => [condition];
}

class InitialBugState extends BugState {}

class ReadyBugState extends BugState {
  List<Bug> bugs;
  List<bool> isVisibles;

  @override
  List<Object> get props => [bugs, isVisibles];
}

class DownloadingBugState extends BugState {
  @override
  List<Object> get props => [condition];

  String get progressString => "Downloading...";
}

class FailedBugState extends BugState {
  String error;
}
