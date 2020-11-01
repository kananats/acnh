import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acnh/bloc/fish_event.dart';
import 'package:acnh/bloc/fish_state.dart';

class FishBloc extends Bloc<FishEvent, FishState> with RepositoryProviderMixin {
  FishBloc() : super(InitialFishState());

  @override
  Stream<FishState> mapEventToState(FishEvent event) async* {
    if (event is InitializeFishEvent) {
      try {
        var fishs = await fishRepository.getFishs();
        if (fishs.isEmpty) throw Exception("Fishs are empty");

        yield SuccessFishState()
          ..fishs = fishs
          ..isVisibles = fishs.map((e) => true).toList();
      } catch (_) {
        yield NotDownloadedFishState();
      }
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
    } else if (event is UpdateFishEvent) {
      await fishRepository.updateFish(event.fish);

      try {
        var fishs = await fishRepository.getFishs();
        if (fishs.isEmpty) throw Exception("Fishs are empty");

        yield SuccessFishState()
          ..fishs = fishs
          ..isVisibles = fishs.map((e) => true).toList();
      } catch (error) {
        yield FailedFishState()..error = error.toString();
      }
    } else if (event is FilterFishEvent) {
      if (state is SuccessFishState) {
        var fishs = await fishRepository.getFishs();
        if (fishs.isEmpty) throw Exception("Fishs are empty");

        yield SuccessFishState()
          ..fishs = fishs
          ..isVisibles = fishs
              .map(
                (fish) => event.condition.apply(fish),
              )
              .toList()
          ..condition = event.condition;
      }
    }
  }
}
