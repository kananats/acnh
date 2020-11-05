import 'package:acnh/bloc/bug/bug_bloc.dart';
import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BlocProviderMixin<T extends StatefulWidget> on State<T> {
  SettingBloc get settingBloc => BlocProvider.of<SettingBloc>(context);
  FishBloc get fishBloc => BlocProvider.of<FishBloc>(context);
  BugBloc get bugBloc => BlocProvider.of<BugBloc>(context);
}
