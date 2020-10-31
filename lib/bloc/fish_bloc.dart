import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acnh/module.dart';
import 'package:acnh/bloc/fish_event.dart';
import 'package:acnh/bloc/fish_state.dart';

mixin FishBlocProviderMixin<T extends StatefulWidget> on State<T> {
  FishBloc get fishBloc => BlocProvider.of<FishBloc>(context);
}

class FishBloc extends Bloc<FishEvent, FishState> {
  FishBloc() : super(InitialFishState());

  @override
  Stream<FishState> mapEventToState(FishEvent event) async* {
    if (event is InitializeFishEvent) {
      try {
        var fishs = await modules.fishRepository.getFishs();
        if (fishs.isEmpty) throw Exception("Fishs are empty");

        yield SuccessFishState()..fishs = fishs;
      } catch (_) {
        yield NotDownloadedFishState();
      }
    } else if (event is DownloadFishEvent) {
      if (state is! DownloadingFishState) {
        try {
          yield DownloadingFishState();

          await modules.fishRepository.fetchFishs();

          var fishs = await modules.fishRepository.getFishs();
          if (fishs.isEmpty) throw Exception("Fishs are empty");

          for (int index = 0; index < fishs.length; index++) {
            yield DownloadingFishState()
              ..count = index + 1
              ..total = fishs.length;

            await modules.fishRepository.downloadFishImage(fishs[index]);
          }

          yield SuccessFishState()..fishs = fishs;
        } catch (error) {
          print(error.toString());
          yield FailedFishState()..error = error.toString();
        }
      }
    }
  }
}
