import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acnh/bloc/fish/fish_event.dart';
import 'package:acnh/bloc/fish/fish_state.dart';

class FishBloc extends Bloc<FishEvent, FishState> with RepositoryProviderMixin {
  FishBloc() : super(InitialFishState()) {
    add(ViewFishEvent());
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

          yield SuccessFishState()
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
      if (state is InitialFishState || state is SuccessFishState) {
        try {
          var tuple = await fishRepository.getFishs();
          var fishs = tuple.item1;
          var isVisibles = tuple.item2;
          if (fishs.isEmpty)
            yield NotDownloadedFishState()
              ..condition = await fishRepository.condition;

          yield SuccessFishState()
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
      if (state is SuccessFishState) {
        await fishRepository.updateFish(event.fish);

        add(ViewFishEvent());
      }
    } else if (event is SetFilterConditionFishEvent) {
      if (state is SuccessFishState) {
        fishRepository.setCondition(event.condition);

        add(ViewFishEvent());
      }
    }
  }
}
