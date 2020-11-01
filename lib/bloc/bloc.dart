import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/bloc/time/time_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BlocProviderMixin<T extends StatefulWidget> on State<T> {
  TimeBloc get timeBloc => BlocProvider.of<TimeBloc>(context);
  FishBloc get fishBloc => BlocProvider.of<FishBloc>(context);
}
