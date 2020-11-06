import 'package:acnh/bloc/bug/bug_bloc.dart';
import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:acnh/dao/dao.dart';
import 'package:acnh/modules.dart';
import 'package:acnh/ui/fish/fish_page.dart';
import 'package:acnh/ui/launch_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            create: (context) => FishBloc(),
          ),
          BlocProvider(
            create: (context) => BugBloc(),
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

// Test code goes here
class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with DaoProviderMixin {
  void test() async {
    var preferences = await modules.localStorage.preferences;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(),
      );
}
