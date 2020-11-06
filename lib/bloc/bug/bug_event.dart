part of 'bug_bloc.dart';

abstract class BugEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class FindBugEvent extends BugEvent {}

class UpdateBugEvent extends BugEvent {
  Bug bug;

  UpdateBugEvent(this.bug);

  @override
  List<Object> get props => [bug];
}

class SetConditionBugEvent extends BugEvent {
  BugFilterCondition condition;

  SetConditionBugEvent(this.condition);

  @override
  List<Object> get props => [condition];
}

class DownloadBugEvent extends BugEvent {
  int count;
  int total;

  @override
  List<Object> get props => [count, total];
}
