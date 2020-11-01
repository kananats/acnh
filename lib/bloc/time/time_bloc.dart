import 'dart:async';

import 'package:acnh/bloc/time/time_event.dart';
import 'package:acnh/bloc/time/time_state.dart';
import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> with RepositoryProviderMixin {
  StreamSubscription<void> _subscription;

  DateTime _freezedDateTime;
  Duration _offset = Duration();

  TimeBloc() : super(NowTimeState()) {
    _subscription = _tickerStream().listen(
      (_) => add(TickTimeEvent()),
    );
  }

  @override
  Stream<TimeState> mapEventToState(TimeEvent event) async* {
    if (event is TickTimeEvent) {
      if (state is NowTimeState)
        yield NowTimeState();
      else if (state is PlayTimeState)
        yield PlayTimeState()
          ..dateTime = DateTime.now().add(
            _offset ?? Duration(),
          );
    } else if (event is PlayTimeEvent) {
      if (state is PauseTimeState) {
        _offset = _freezedDateTime.difference(DateTime.now());
        yield PlayTimeState()..dateTime = DateTime.now().add(_offset);
      }
    } else if (event is PauseTimeEvent) {
      if (state is NowTimeState) {
        _freezedDateTime = DateTime.now();
        yield PauseTimeState()..dateTime = _freezedDateTime;
      } else if (state is PlayTimeState) {
        _freezedDateTime = state.dateTime;
        yield PauseTimeState()..dateTime = _freezedDateTime;
      }
    } else if (event is ResetTimeEvent) {
      yield NowTimeState();
    }
  }

  static Stream<void> _tickerStream() => Stream.periodic(Duration(seconds: 1));
}
