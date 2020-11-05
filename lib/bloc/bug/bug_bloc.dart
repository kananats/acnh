// ignore_for_file: cancel_subscriptions
// ignore_for_file: unused_field

import 'dart:async';

import 'package:acnh/data/clock.dart';
import 'package:acnh/dto/bug.dart';
import 'package:acnh/dto/bug_filter_condition.dart';
import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bug_event.dart';
part 'bug_state.dart';

class BugBloc extends Bloc<BugEvent, BugState>
    with RepositoryProviderMixin, ClockProviderMixin {
  StreamSubscription<DateTime> _subscription;

  BugBloc() : super(InitialBugState()) {
    _subscription = clock.stream.listen(
      (event) => add(ViewBugEvent()),
    );
  }

  @override
  Stream<BugState> mapEventToState(BugEvent event) async* {
    if (event is DownloadBugEvent) {
      if (state is! DownloadingBugState) {
        try {
          yield DownloadingBugState()
            ..condition = await bugRepository.condition;

          await bugRepository.fetchBugs();

          var tuple = await bugRepository.getBugs();
          var bugs = tuple.item1;
          var isVisibles = tuple.item2;

          if (bugs.isEmpty) throw Exception("Bugs are empty");

          for (int index = 0; index < bugs.length; index++) {
            yield DownloadingBugState()
              ..condition = await bugRepository.condition
              ..count = index + 1
              ..total = bugs.length;

            await bugRepository.downloadBugImage(bugs[index]);
          }

          yield ReadyBugState()
            ..condition = await bugRepository.condition
            ..bugs = bugs
            ..isVisibles = isVisibles;
        } catch (error) {
          yield FailedBugState()
            ..condition = await bugRepository.condition
            ..error = error.toString();
        }
      }
    } else if (event is ViewBugEvent) {
      if (state is InitialBugState || state is ReadyBugState) {
        try {
          var tuple = await bugRepository.getBugs();
          var bugs = tuple.item1;
          var isVisibles = tuple.item2;

          if (bugs.isEmpty) {
            yield InitialBugState()..condition = await bugRepository.condition;
            return;
          }
          yield ReadyBugState()
            ..condition = await bugRepository.condition
            ..bugs = bugs
            ..isVisibles = isVisibles;
        } catch (error) {
          yield FailedBugState()
            ..condition = await bugRepository.condition
            ..error = error.toString();
        }
      }
    } else if (event is UpdateBugEvent) {
      if (state is ReadyBugState) {
        await bugRepository.updateBug(event.bug);

        add(ViewBugEvent());
      }
    } else if (event is SetFilterConditionBugEvent) {
      await bugRepository.setCondition(event.condition);

      if (state is ReadyBugState) add(ViewBugEvent());
    }
  }
}
