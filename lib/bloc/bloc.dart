import 'package:acnh/bloc/art/art_bloc.dart';
import 'package:acnh/bloc/bug/bug_bloc.dart';
import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/bloc/fossil/fossil_bloc.dart';
import 'package:acnh/bloc/sea/sea_bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:acnh/bloc/villager/villager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BlocProviderMixin<T extends StatefulWidget> on State<T> {
  SettingBloc get settingBloc => BlocProvider.of<SettingBloc>(context);
  VillagerBloc get villagerBloc => BlocProvider.of<VillagerBloc>(context);
  FishBloc get fishBloc => BlocProvider.of<FishBloc>(context);
  BugBloc get bugBloc => BlocProvider.of<BugBloc>(context);
  SeaBloc get seaBloc => BlocProvider.of<SeaBloc>(context);
  FossilBloc get fossilBloc => BlocProvider.of<FossilBloc>(context);
  ArtBloc get artBloc => BlocProvider.of<ArtBloc>(context);
}
