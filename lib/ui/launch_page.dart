import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/ui/fish/fish_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => BlocConsumer<FishBloc, FishState>(
        listener: (context, state) {
          if (state is ReadyFishState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => FishPage()),
            );
          }
        },
        builder: (context, state) => Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
}
