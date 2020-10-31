import 'package:acnh/bloc/fish_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BlocProviderMixin<T extends StatefulWidget> on State<T> {
  FishBloc get fishBloc => BlocProvider.of<FishBloc>(context);
}
