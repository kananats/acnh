import 'package:acnh/fish/fish_event.dart';
import 'package:acnh/fish/fish_state.dart';
import 'package:acnh/module.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    if (event is FetchFishEvent) {
      if (state is InitialFishState) {
        try {
          var fishs = await modules.fishRepository.getFishes();
          yield SuccessFishState()..fishs = fishs;
        } catch (_) {
          yield FailedFishState();
        }
      }
    }
  }
}
