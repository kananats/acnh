// ignore_for_file: cancel_subscriptions
// ignore_for_file: unused_field

import 'dart:async';

import 'package:acnh/data/clock.dart';
import 'package:acnh/dto/fossil.dart';
import 'package:acnh/dto/fossil_filter_condition.dart';
import 'package:acnh/error/error.dart';
import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

part 'fossil_event.dart';
part 'fossil_state.dart';

class FossilBloc extends Bloc<FossilEvent, FossilState>
    with RepositoryProviderMixin, ClockProviderMixin {
  StreamSubscription<DateTime> _subscription;

  FossilBloc() : super(InitialFossilState()) {
    _subscription = clock.stream.listen(
      (event) => add(FindFossilEvent()),
    );
  }

  @override
  Stream<FossilState> mapEventToState(FossilEvent event) async* {
    if (state is InitialFossilState) {
      if (event is FindFossilEvent) {
        List<Tuple2<Fossil, bool>> tuples;
        try {
          tuples = await fossilRepository.findFossils();
        } on NoFossilError {
          tuples = await fossilRepository.fetchFossils();
        }

        yield ReadyFossilState()
          ..condition = await fossilRepository.condition
          ..fossils = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      }
    } else if (state is ReadyFossilState) {
      if (event is FindFossilEvent) {
        List<Tuple2<Fossil, bool>> tuples;
        try {
          tuples = await fossilRepository.findFossils();
        } on NoFossilError {
          return;
        }

        yield ReadyFossilState()
          ..condition = await fossilRepository.condition
          ..fossils = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      } else if (event is UpdateFossilEvent) {
        await fossilRepository.updateFossil(event.fossil);

        add(FindFossilEvent());
      } else if (event is SetConditionFossilEvent) {
        await fossilRepository.setCondition(event.condition);

        add(FindFossilEvent());
      } else if (event is DownloadFossilEvent) {
        yield DownloadingFossilState()
          ..condition = await fossilRepository.condition;

        var tuples = await fossilRepository.fetchFossils();

        await fossilRepository.downloadFossilImages();
        tuples = await fossilRepository.findFossils();

        yield ReadyFossilState()
          ..condition = await fossilRepository.condition
          ..fossils = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      }
    }
  }
}
