part of 'bug_bloc.dart';

abstract class BugState with EquatableMixin {
  BugFilterCondition condition;

  @override
  List<Object> get props => [condition];
}

class InitialBugState extends BugState {}

class DownloadingBugState extends BugState {
  int count;
  int total;

  @override
  List<Object> get props => [condition, count, total];

  String get downloadingString => count != null && total != null
      ? "Downloading $count of $total"
      : "Downloading...";
}

class ReadyBugState extends BugState {
  List<Bug> bugs;
  List<bool> isVisibles;

  @override
  List<Object> get props => [bugs, isVisibles];
}

class FailedBugState extends BugState {
  String error;
}
