import 'dart:io';

import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:acnh/dao/dao.dart';
import 'package:acnh/module.dart';
import 'package:acnh/ui/fish/fish_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingBloc = SettingBloc();
    final fishBloc = FishBloc();

    settingBloc.fishBloc = fishBloc;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => settingBloc,
        ),
        BlocProvider(
          create: (context) => fishBloc,
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

    test();
  }

  void test() async {
    var preferences = await modules.localStorage.preferences;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          child: Image.file(
            File(
                "/Users/kananats/Library/Developer/CoreSimulator/Devices/1DA5A9A1-55AC-4C16-B60C-D8CF1E7D869B/data/Containers/Data/Application/56EABFB1-C908-4F63-922D-84AF8FAB62C8/Documents/downloads/acnhapi.com/v1/images/fish/1.png"),
          ),
        ),
      );
}
