// ignore_for_file: cancel_subscriptions
// ignore_for_file: unused_field

import 'dart:async';

import 'package:acnh/data/clock.dart';
import 'package:acnh/dto/villager.dart';
import 'package:acnh/dto/villager_filter_condition.dart';
import 'package:acnh/error/error.dart';
import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

part 'villager_event.dart';
part 'villager_state.dart';

class VillagerBloc extends Bloc<VillagerEvent, VillagerState>
    with RepositoryProviderMixin, ClockProviderMixin {
  StreamSubscription<DateTime> _subscription;

  VillagerBloc() : super(InitialVillagerState()) {
    _subscription = clock.stream.listen(
      (event) => add(FindVillagerEvent()),
    );
  }

  @override
  Stream<VillagerState> mapEventToState(VillagerEvent event) async* {
    if (state is InitialVillagerState) {
      if (event is FindVillagerEvent) {
        List<Tuple2<Villager, bool>> tuples;
        try {
          tuples = await villagerRepository.findVillagers();
        } on NoVillagerError {
          tuples = await villagerRepository.fetchVillagers();
        }

        yield ReadyVillagerState()
          ..condition = await villagerRepository.condition
          ..villagers = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      }
    } else if (state is ReadyVillagerState) {
      if (event is FindVillagerEvent) {
        List<Tuple2<Villager, bool>> tuples;
        try {
          tuples = await villagerRepository.findVillagers();
        } on NoVillagerError {
          return;
        }

        yield ReadyVillagerState()
          ..condition = await villagerRepository.condition
          ..villagers = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      } else if (event is UpdateVillagerEvent) {
        await villagerRepository.updateVillager(event.villager);

        add(FindVillagerEvent());
      } else if (event is SetConditionVillagerEvent) {
        await villagerRepository.setCondition(event.condition);

        add(FindVillagerEvent());
      } else if (event is DownloadVillagerEvent) {
        yield DownloadingVillagerState()
          ..condition = await villagerRepository.condition;

        var tuples = await villagerRepository.fetchVillagers();

        await villagerRepository.downloadVillagerImages();
        tuples = await villagerRepository.findVillagers();

        yield ReadyVillagerState()
          ..condition = await villagerRepository.condition
          ..villagers = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      }
    }
  }
}
