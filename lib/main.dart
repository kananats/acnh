import 'package:acnh/bloc/art/art_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acnh/bloc/bug/bug_bloc.dart';
import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/bloc/fossil/fossil_bloc.dart';
import 'package:acnh/bloc/sea/sea_bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:acnh/bloc/villager/villager_bloc.dart';
import 'package:acnh/ui/launch_page.dart';

void main() {
  EquatableConfig.stringify = true;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => SettingBloc(),
          ),
          BlocProvider(
            create: (context) => VillagerBloc(),
          ),
          BlocProvider(
            create: (context) => FishBloc(),
          ),
          BlocProvider(
            create: (context) => BugBloc(),
          ),
          BlocProvider(
            create: (context) => SeaBloc(),
          ),
          BlocProvider(
            create: (context) => FossilBloc(),
          ),
          BlocProvider(
            create: (context) => ArtBloc(),
          ),
        ],
        child: MaterialApp(
          title: "acnh",
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: LaunchPage(),
        ),
      );
}
