// ignore_for_file: cancel_subscriptions
// ignore_for_file: unused_field

import 'dart:async';

import 'package:acnh/data/clock.dart';
import 'package:acnh/dto/fish.dart';
import 'package:acnh/dto/fish_filter_condition.dart';
import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fish_event.dart';
part 'fish_state.dart';

class FishBloc extends Bloc<FishEvent, FishState>
    with RepositoryProviderMixin, ClockProviderMixin {
  StreamSubscription<DateTime> _subscription;

  FishBloc() : super(InitialFishState()) {
    _subscription = clock.stream.listen(
      (event) => add(ViewFishEvent()),
    );
  }

  @override
  Stream<FishState> mapEventToState(FishEvent event) async* {
    if (event is DownloadFishEvent) {
      if (state is! DownloadingFishState) {
        try {
          yield DownloadingFishState()
            ..condition = await fishRepository.condition;

          await fishRepository.fetchFishs();

          var tuple = await fishRepository.getFishs();
          var fishs = tuple.item1;
          var isVisibles = tuple.item2;

          if (fishs.isEmpty) throw Exception("Fishs are empty");

          for (int index = 0; index < fishs.length; index++) {
            yield DownloadingFishState()
              ..condition = await fishRepository.condition
              ..count = index + 1
              ..total = fishs.length;

            await fishRepository.downloadFishImage(fishs[index]);
          }

          yield ReadyFishState()
            ..condition = await fishRepository.condition
            ..fishs = fishs
            ..isVisibles = isVisibles;
        } catch (error) {
          yield FailedFishState()
            ..condition = await fishRepository.condition
            ..error = error.toString();
        }
      }
    } else if (event is ViewFishEvent) {
      if (state is InitialFishState || state is ReadyFishState) {
        try {
          var tuple = await fishRepository.getFishs();
          var fishs = tuple.item1;
          var isVisibles = tuple.item2;

          if (fishs.isEmpty) {
            yield InitialFishState()
              ..condition = await fishRepository.condition;
            return;
          }
          yield ReadyFishState()
            ..condition = await fishRepository.condition
            ..fishs = fishs
            ..isVisibles = isVisibles;
        } catch (error) {
          yield FailedFishState()
            ..condition = await fishRepository.condition
            ..error = error.toString();
        }
      }
    } else if (event is UpdateFishEvent) {
      if (state is ReadyFishState) {
        await fishRepository.updateFish(event.fish);

        add(ViewFishEvent());
      }
    } else if (event is SetFilterConditionFishEvent) {
      await fishRepository.setCondition(event.condition);

      if (state is ReadyFishState) add(ViewFishEvent());
    }
  }
}
