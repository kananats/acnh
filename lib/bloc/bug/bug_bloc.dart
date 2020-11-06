// ignore_for_file: cancel_subscriptions
// ignore_for_file: unused_field

import 'dart:async';

import 'package:acnh/data/clock.dart';
import 'package:acnh/dto/bug.dart';
import 'package:acnh/dto/bug_filter_condition.dart';
import 'package:acnh/error/error.dart';
import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

part 'bug_event.dart';
part 'bug_state.dart';

class BugBloc extends Bloc<BugEvent, BugState>
    with RepositoryProviderMixin, ClockProviderMixin {
  StreamSubscription<DateTime> _subscription;

  BugBloc() : super(InitialBugState()) {
    _subscription = clock.stream.listen(
      (event) => add(FindBugEvent()),
    );
  }

  @override
  Stream<BugState> mapEventToState(BugEvent event) async* {
    if (state is InitialBugState) {
      if (event is FindBugEvent) {
        List<Tuple2<Bug, bool>> tuples;
        try {
          tuples = await bugRepository.findBugs();
        } on NoBugError {
          tuples = await bugRepository.fetchBugs();
        }

        yield ReadyBugState()
          ..condition = await bugRepository.condition
          ..bugs = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      }
    } else if (state is ReadyBugState) {
      if (event is FindBugEvent) {
        List<Tuple2<Bug, bool>> tuples;
        try {
          tuples = await bugRepository.findBugs();
        } on NoBugError {
          return;
        }

        yield ReadyBugState()
          ..condition = await bugRepository.condition
          ..bugs = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      } else if (event is UpdateBugEvent) {
        await bugRepository.updateBug(event.bug);

        add(FindBugEvent());
      } else if (event is SetConditionBugEvent) {
        await bugRepository.setCondition(event.condition);

        add(FindBugEvent());
      } else if (event is DownloadBugEvent) {
        yield DownloadingBugState()..condition = await bugRepository.condition;

        var tuples = await bugRepository.fetchBugs();

        await bugRepository.downloadBugImages();
        tuples = await bugRepository.findBugs();

        yield ReadyBugState()
          ..condition = await bugRepository.condition
          ..bugs = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      }
    }
  }
}
