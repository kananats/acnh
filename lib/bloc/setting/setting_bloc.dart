import 'dart:async';

import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/bloc/fish/fish_event.dart';
import 'package:acnh/bloc/setting/setting_event.dart';
import 'package:acnh/bloc/setting/setting_state.dart';
import 'package:acnh/dto/settings.dart';
import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState>
    with RepositoryProviderMixin {
  FishBloc fishBloc;

  StreamSubscription<void> _subscription;

  Setting setting;

  SettingBloc() : super(InitialSettingState()) {
    add(InitializeSettingEvent());

    _subscription = _tickerStream().listen(
      (_) => add(TimeTickSettingEvent()),
    );
  }

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    fishBloc?.add(ViewFishEvent()); // TODO: optimization

    if (event is InitializeSettingEvent) {
      if (state is InitialSettingState) {
        setting = await settingRepository.setting;
        if (setting.offset != null)
          yield TimePlaySettingState()
            ..dateTime = DateTime.now().add(setting.offset);
        else if (setting.dateTime != null)
          yield TimePauseSettingState()..dateTime = setting.dateTime;
        else
          yield TimeNowSettingState();
      }
    } else if (event is TimeTickSettingEvent) {
      if (state is TimeNowSettingState)
        yield TimeNowSettingState();
      else if (state is TimePlaySettingState)
        yield TimePlaySettingState()
          ..dateTime = DateTime.now().add(
            setting.offset ?? Duration(),
          );
    } else if (event is TimePlaySettingEvent) {
      if (state is TimePauseSettingState) {
        setting.offset = setting.dateTime.difference(DateTime.now());
        setting.dateTime = null;
        settingRepository.setSetting(setting);
        yield TimePlaySettingState()
          ..dateTime = DateTime.now().add(setting.offset);
      }
    } else if (event is TimePauseSettingEvent) {
      setting.offset = null;
      if (state is TimeNowSettingState)
        setting.dateTime = event.dateTime ?? DateTime.now();
      else
        setting.dateTime = event.dateTime ?? state.dateTime;

      settingRepository.setSetting(setting);
      yield TimePauseSettingState()..dateTime = setting.dateTime;
    } else if (event is TimeResetSettingEvent) {
      yield TimeNowSettingState();
    }
  }

  static Stream<void> _tickerStream() => Stream.periodic(Duration(seconds: 1));
}
