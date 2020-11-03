import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BlocProviderMixin<T extends StatefulWidget> on State<T> {
  SettingBloc get timeBloc => BlocProvider.of<SettingBloc>(context);
  FishBloc get fishBloc => BlocProvider.of<FishBloc>(context);
}
