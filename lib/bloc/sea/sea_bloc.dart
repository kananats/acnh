// ignore_for_file: cancel_subscriptions
// ignore_for_file: unused_field

import 'dart:async';

import 'package:acnh/data/clock.dart';
import 'package:acnh/dto/sea.dart';
import 'package:acnh/dto/sea_filter_condition.dart';
import 'package:acnh/error/error.dart';
import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

part 'sea_event.dart';
part 'sea_state.dart';

class SeaBloc extends Bloc<SeaEvent, SeaState>
    with RepositoryProviderMixin, ClockProviderMixin {
  StreamSubscription<DateTime> _subscription;

  SeaBloc() : super(InitialSeaState()) {
    _subscription = clock.stream.listen(
      (event) => add(FindSeaEvent()),
    );
  }

  @override
  Stream<SeaState> mapEventToState(SeaEvent event) async* {
    if (state is InitialSeaState) {
      if (event is FindSeaEvent) {
        List<Tuple2<Sea, bool>> tuples;
        try {
          tuples = await seaRepository.findSeas();
        } on NoSeaError {
          tuples = await seaRepository.fetchSeas();
        }

        yield ReadySeaState()
          ..condition = await seaRepository.condition
          ..seas = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      }
    } else if (state is ReadySeaState) {
      if (event is FindSeaEvent) {
        List<Tuple2<Sea, bool>> tuples;
        try {
          tuples = await seaRepository.findSeas();
        } on NoSeaError {
          return;
        }

        yield ReadySeaState()
          ..condition = await seaRepository.condition
          ..seas = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      } else if (event is UpdateSeaEvent) {
        await seaRepository.updateSea(event.sea);

        add(FindSeaEvent());
      } else if (event is SetConditionSeaEvent) {
        await seaRepository.setCondition(event.condition);

        add(FindSeaEvent());
      } else if (event is DownloadSeaEvent) {
        yield DownloadingSeaState()..condition = await seaRepository.condition;

        var tuples = await seaRepository.fetchSeas();

        await seaRepository.downloadSeaImages();
        tuples = await seaRepository.findSeas();

        yield ReadySeaState()
          ..condition = await seaRepository.condition
          ..seas = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      }
    }
  }
}
