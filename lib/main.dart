import 'dart:io';

import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:acnh/dao/dao.dart';
import 'package:acnh/module.dart';
import 'package:acnh/ui/fish/fish_page.dart';
import 'package:acnh/ui/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

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
        ],
        child: MaterialApp(
          title: "acnh",
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FishPage(),
        ),
      );
}

// Test code goes here
class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with DaoProviderMixin {
  @override
  void initState() {
    super.initState();

    modules.clock.stream.listen((event) => setState(() {}));
    test();
  }

  void test() async {
    var preferences = await modules.localStorage.preferences;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            modules.clock.toggle();
          },
        ),
        body: Container(
          child: Center(
            child: Text(modules.clock.now.toString()),
          ),
        ),
      );
}
