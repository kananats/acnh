part of 'bug_bloc.dart';

abstract class BugEvent with EquatableMixin {
  @override
  List<Object> get props => [];
}

class DownloadBugEvent extends BugEvent {
  int count;
  int total;

  @override
  List<Object> get props => [count, total];
}

class ViewBugEvent extends BugEvent {}

class UpdateBugEvent extends BugEvent {
  Bug bug;

  UpdateBugEvent(this.bug);
}

class SetFilterConditionBugEvent extends BugEvent {
  BugFilterCondition condition;

  SetFilterConditionBugEvent(this.condition);
}
