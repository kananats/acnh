// ignore_for_file: cancel_subscriptions
// ignore_for_file: unused_field

import 'dart:async';

import 'package:acnh/data/clock.dart';
import 'package:acnh/dto/language_enum.dart';
import 'package:acnh/dto/setting.dart';
import 'package:acnh/modules.dart';
import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState>
    with RepositoryProviderMixin, ClockProviderMixin {
  StreamSubscription<DateTime> _subscription;

  SettingBloc() : super(InitialSettingState()) {
    _subscription = clock.stream.listen(
      (event) => add(
        TickSettingEvent()..dateTime = event,
      ),
    );
  }

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (state is InitialSettingState) {
      if (event is TickSettingEvent) {
        var setting = await settingRepository.setting;
        yield ReadySettingState()
          ..setting = setting
          ..dateTime = event.dateTime;
      }
    } else if (state is ReadySettingState) {
      if (event is TickSettingEvent) {
        var setting = (await settingRepository.setting).copy();
        yield ReadySettingState()
          ..setting = setting
          ..dateTime = clock.now;
      } else if (event is SetLanguageSettingEvent) {
        var setting = (await settingRepository.setting).copy();
        setting.language = event.language;
        await settingRepository.setSetting(setting);
        yield ReadySettingState()
          ..setting = setting
          ..dateTime = clock.now;
      } else if (event is SetDateSettingEvent) {
        await modules.clock.setDate(event.date);
        var setting = await settingRepository.setting;
        yield ReadySettingState()
          ..setting = setting
          ..dateTime = clock.now;
      } else if (event is SetTimeSettingEvent) {
        await modules.clock.setTime(event.time);
        var setting = await settingRepository.setting;
        yield ReadySettingState()
          ..setting = setting
          ..dateTime = clock.now;
      } else if (event is ToggleFreezeSettingEvent) {
        await modules.clock.toggle();
        var setting = await settingRepository.setting;
        yield ReadySettingState()
          ..setting = setting
          ..dateTime = clock.now;
      } else if (event is ResetTimeSettingEvent) {
        await clock.reset();
        var setting = await settingRepository.setting;
        yield ReadySettingState()
          ..setting = setting
          ..dateTime = clock.now;
      }
    }
  }
}
