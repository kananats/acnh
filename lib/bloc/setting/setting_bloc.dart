import 'dart:async';

import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/bloc/fish/fish_event.dart';
import 'package:acnh/bloc/setting/setting_event.dart';
import 'package:acnh/bloc/setting/setting_state.dart';
import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState>
    with RepositoryProviderMixin {
  FishBloc fishBloc;

  StreamSubscription<void> _subscription;

  SettingBloc() : super(InitialSettingState()) {
    add(InitializeSettingEvent()); // TODO: can we simplify?

    _subscription = _tickerStream().listen(
      (_) => add(TimeTickSettingEvent()),
    );
  }

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (event is InitializeSettingEvent) {
      if (state is InitialSettingState) {
        var setting = await settingRepository.setting;
        if (setting.freezedOffset != null)
          yield TimePlaySettingState()
            ..setting = setting
            ..dateTime = DateTime.now().add(setting.freezedOffset);
        else if (setting.freezedDateTime != null)
          yield TimePauseSettingState()
            ..setting = setting
            ..dateTime = setting.freezedDateTime;
        else
          yield TimeNowSettingState()..setting = setting;
      }
    } else if (event is SetLanguageSettingEvent) {
      var state = this.state.copy();
      var setting = (await settingRepository.setting).copy();
      setting.language = event.language;
      settingRepository.setSetting(setting);

      yield state..setting = setting;
    } else if (event is TimeTickSettingEvent) {
      if (state is TimeNowSettingState)
        yield TimeNowSettingState()..setting = await settingRepository.setting;
      else if (state is TimePlaySettingState) {
        var setting = await settingRepository.setting;
        yield TimePlaySettingState()
          ..setting = setting
          ..dateTime = DateTime.now().add(setting.freezedOffset);
      }
    } else if (event is TimePlaySettingEvent) {
      if (state is TimePauseSettingState) {
        var setting = await settingRepository.setting;

        setting.freezedOffset =
            setting.freezedDateTime.difference(DateTime.now());
        setting.freezedDateTime = null;
        settingRepository.setSetting(setting);
        yield TimePlaySettingState()
          ..setting = setting
          ..dateTime = DateTime.now().add(setting.freezedOffset);
      }
    } else if (event is TimePauseSettingEvent) {
      var setting = await settingRepository.setting;

      setting.freezedOffset = null;
      if (state is TimeNowSettingState)
        setting.freezedDateTime = event.dateTime ?? DateTime.now();
      else
        setting.freezedDateTime = event.dateTime ?? state.dateTime;

      settingRepository.setSetting(setting);
      yield TimePauseSettingState()
        ..setting = setting
        ..dateTime = setting.freezedDateTime;
    } else if (event is TimeResetSettingEvent) {
      yield TimeNowSettingState()..setting = await settingRepository.setting;
    }

    fishBloc?.add(ViewFishEvent()); // TODO: optimization
  }

  static Stream<void> _tickerStream() => Stream.periodic(Duration(seconds: 1));
}
