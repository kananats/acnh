// ignore_for_file: cancel_subscriptions
// ignore_for_file: unused_field

import 'dart:async';

import 'package:acnh/data/clock.dart';
import 'package:acnh/dto/art.dart';
import 'package:acnh/dto/art_filter_condition.dart';
import 'package:acnh/error/error.dart';
import 'package:acnh/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

part 'art_event.dart';
part 'art_state.dart';

class ArtBloc extends Bloc<ArtEvent, ArtState>
    with RepositoryProviderMixin, ClockProviderMixin {
  StreamSubscription<DateTime> _subscription;

  ArtBloc() : super(InitialArtState()) {
    _subscription = clock.stream.listen(
      (event) => add(FindArtEvent()),
    );
  }

  @override
  Stream<ArtState> mapEventToState(ArtEvent event) async* {
    if (state is InitialArtState) {
      if (event is FindArtEvent) {
        List<Tuple2<Art, bool>> tuples;
        try {
          tuples = await artRepository.findArts();
        } on NoArtError {
          tuples = await artRepository.fetchArts();
        }

        yield ReadyArtState()
          ..condition = await artRepository.condition
          ..arts = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      }
    } else if (state is ReadyArtState) {
      if (event is FindArtEvent) {
        List<Tuple2<Art, bool>> tuples;
        try {
          tuples = await artRepository.findArts();
        } on NoArtError {
          return;
        }

        yield ReadyArtState()
          ..condition = await artRepository.condition
          ..arts = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      } else if (event is UpdateArtEvent) {
        await artRepository.updateArt(event.art);

        add(FindArtEvent());
      } else if (event is SetConditionArtEvent) {
        await artRepository.setCondition(event.condition);

        add(FindArtEvent());
      } else if (event is DownloadArtEvent) {
        yield DownloadingArtState()..condition = await artRepository.condition;

        var tuples = await artRepository.fetchArts();

        await artRepository.downloadArtImages();
        tuples = await artRepository.findArts();

        yield ReadyArtState()
          ..condition = await artRepository.condition
          ..arts = tuples.map((e) => e.item1).toList()
          ..isVisibles = tuples.map((e) => e.item2).toList();
      }
    }
  }
}
