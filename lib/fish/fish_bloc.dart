import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acnh/fish/fish_event.dart';
import 'package:acnh/fish/fish_state.dart';
import 'package:acnh/module.dart';

mixin FishBlocProviderMixin<T extends StatefulWidget> on State<T> {
  FishBloc fishBloc;

  @override
  void initState() {
    super.initState();

    fishBloc = BlocProvider.of<FishBloc>(context);
  }

  @override
  void dispose() {
    fishBloc.close();

    super.dispose();
  }
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
      if (state is DownloadingFishState)
        yield DownloadingFishState()
          ..count = event.count
          ..total = event.total;
      else {
        try {
          yield DownloadingFishState();

          await modules.fishRepository.fetchFishs(
            onReceiveProgress: (count, total) => onEvent(
              DownloadFishEvent()
                ..count = count
                ..total = total,
            ),
          );

          var fishs = await modules.fishRepository.getFishs();
          if (fishs.isEmpty) throw Exception("Fishs are empty");

          yield SuccessFishState()..fishs = fishs;
        } catch (_) {
          yield FailedFishState();
        }
      }
    }
  }
}
