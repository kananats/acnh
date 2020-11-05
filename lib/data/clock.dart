// ignore_for_file: cancel_subscriptions
// ignore_for_file: unused_field

import 'dart:async';

import 'package:acnh/modules.dart';
import 'package:acnh/repository/repository.dart';
import 'package:flutter/material.dart';

mixin ClockProviderMixin {
  Clock get clock => modules.clock;
}

class Clock with RepositoryProviderMixin {
  StreamSubscription<DateTime> _subscription;

  DateTime _now;

  Stream<DateTime> _stream;

  bool _isPlaying = true;

  DateTime get now => _now;

  Stream<DateTime> get stream => _stream;

  bool get isPlaying => _isPlaying;

  Clock() {
    _stream = _makeStream().asBroadcastStream();
  }

  Stream<DateTime> _makeStream() async* {
    while (true) {
      var setting = await settingRepository.setting;

      if (setting == null)
        _now = DateTime.now();
      else if (setting.freezedDateTime != null) {
        _now = setting.freezedDateTime;
        _isPlaying = false;
      } else if (setting.dateTimeOffset != null) {
        _now = DateTime.now().add(setting.dateTimeOffset);
        _isPlaying = true;
      } else
        _now = DateTime.now();
      yield _now;

      await Future.delayed(Duration(seconds: 1));
    }
  }

  Future<void> play() async {
    if (_isPlaying) return;
    _isPlaying = true;

    var setting = await settingRepository.setting;

    setting.dateTimeOffset = setting.freezedDateTime.difference(DateTime.now());
    setting.freezedDateTime = null;

    await settingRepository.setSetting(setting);
  }

  Future<void> pause() async {
    if (!isPlaying) return;
    _isPlaying = false;

    var setting = await settingRepository.setting;

    setting.dateTimeOffset = null;
    setting.freezedDateTime = _now;

    await settingRepository.setSetting(setting);
  }

  Future<void> toggle() async {
    if (isPlaying)
      await pause();
    else
      await play();
  }

  Future<void> setDateTime(DateTime dateTime) async {
    var setting = await settingRepository.setting;

    if (setting.dateTimeOffset != null)
      setting.dateTimeOffset = dateTime.difference(DateTime.now());
    else if (setting.freezedDateTime != null)
      setting.freezedDateTime = dateTime;
    await settingRepository.setSetting(setting);
  }

  Future<void> setDate(DateTime date) async {
    var now = _now.toLocal();
    var dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      now.hour,
      now.minute,
    );

    await setDateTime(dateTime);
  }

  Future<void> setTime(TimeOfDay time) async {
    var now = _now.toLocal();
    var dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    await setDateTime(dateTime);
  }

  Future<void> reset() async {
    var setting = await settingRepository.setting;

    setting.dateTimeOffset = null;
    setting.freezedDateTime = null;

    await settingRepository.setSetting(setting);
  }
}
