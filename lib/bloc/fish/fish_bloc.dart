// ignore_for_file: cancel_subscriptions
// ignore_for_file: unused_field

import 'dart:async';

import 'package:acnh/data/clock.dart';
import 'package:acnh/dto/fish.dart';
import 'package:acnh/dto/fish_filter_condition.dart';
import 'package:acnh/error/error.dart';
import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

part 'fish_event.dart';
part 'fish_state.dart';

class FishBloc extends Bloc<FishEvent, FishState>
    with RepositoryProviderMixin, ClockProviderMixin {
  StreamSubscription<DateTime> _subscription;

  FishBloc() : super(InitialFishState()) {
    _subscription = clock.stream.listen(
      (event) => add(FindFishEvent()),
    );
  }

  @override
  Stream<FishState> mapEventToState(FishEvent event) async* {
    if (state is InitialFishState) {
      if (event is FindFishEvent) {
        List<Tuple2<Fish, bool>> tuples;
        try {
          tuples = await fishRepository.findFishs();
        } on NoFishError {
          tuples = await fishRepository.fetchFishs();
        }

        yield ReadyFishState()
          ..condition = await fishRepository.condition
          ..fishs = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      }
    } else if (state is ReadyFishState) {
      if (event is FindFishEvent) {
        List<Tuple2<Fish, bool>> tuples;
        try {
          tuples = await fishRepository.findFishs();
        } on NoFishError {
          return;
        }

        yield ReadyFishState()
          ..condition = await fishRepository.condition
          ..fishs = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      } else if (event is UpdateFishEvent) {
        await fishRepository.updateFish(event.fish);

        add(FindFishEvent());
      } else if (event is SetConditionFishEvent) {
        await fishRepository.setCondition(event.condition);

        add(FindFishEvent());
      } else if (event is DownloadFishEvent) {
        yield DownloadingFishState()
          ..condition = await fishRepository.condition;

        var tuples = await fishRepository.fetchFishs();

        await fishRepository.downloadFishImages();
        tuples = await fishRepository.findFishs();

        yield ReadyFishState()
          ..condition = await fishRepository.condition
          ..fishs = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      }
    }
  }
}
