import 'package:acnh/bloc/time/time_bloc.dart';
import 'package:acnh/repository/repository.dart';
import 'package:acnh/ui/fish/fish_filter_condition.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acnh/bloc/fish/fish_event.dart';
import 'package:acnh/bloc/fish/fish_state.dart';

class FishBloc extends Bloc<FishEvent, FishState> with RepositoryProviderMixin {
  TimeBloc timeBloc;

  FishFilterCondition condition;

  FishBloc({@required this.timeBloc}) : super(InitialFishState()) {
    add(InitializeFishEvent());
  }

  @override
  Stream<FishState> mapEventToState(FishEvent event) async* {
    if (event is InitializeFishEvent) {
      var preferences = await fileRepository.preferences;
      condition = FishFilterCondition.fromPreferences(preferences);

      add(ViewFishEvent());
    } else if (event is DownloadFishEvent) {
      if (state is! DownloadingFishState) {
        try {
          yield DownloadingFishState();

          await fishRepository.fetchFishs();

          var fishs = await fishRepository.getFishs();
          if (fishs.isEmpty) throw Exception("Fishs are empty");

          for (int index = 0; index < fishs.length; index++) {
            yield DownloadingFishState()
              ..count = index + 1
              ..total = fishs.length;

            await fishRepository.downloadFishImage(fishs[index]);
          }
          yield SuccessFishState()
            ..fishs = fishs
            ..isVisibles = fishs.map((e) => true).toList();
        } catch (error) {
          yield FailedFishState()..error = error.toString();
        }
      }
    } else if (event is ViewFishEvent) {
      try {
        var fishs = await fishRepository.getFishs();
        if (fishs.isEmpty) throw Exception("Fishs are empty");

        yield SuccessFishState()
          ..fishs = fishs
          ..isVisibles = fishs
              .map(
                (fish) => condition.apply(
                  fish,
                  timeBloc.state.dateTime,
                ),
              )
              .toList();
      } catch (_) {
        yield NotDownloadedFishState();
      }
    } else if (event is UpdateFishEvent) {
      await fishRepository.updateFish(event.fish);

      add(ViewFishEvent());
    } else if (event is SetFilterConditionFishEvent) {
      if (state is SuccessFishState) {
        condition = event.condition;

        var preferences = await fileRepository.preferences;
        condition.toPreferences(preferences);

        add(ViewFishEvent());
      }
    }
  }
}