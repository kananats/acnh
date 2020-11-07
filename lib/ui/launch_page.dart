import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/bug/bug_bloc.dart';
import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/ui/fish/fish_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> with BlocProviderMixin {
  bool _isFishReady = false;
  bool _isBugReady = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _fishListener(
          child: _bugListener(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );

  Widget _fishListener({Widget child}) => BlocListener<FishBloc, FishState>(
        listener: (context, state) {
          if (state is ReadyFishState) _isFishReady = true;
          _navigateIfReady(context);
        },
        child: child,
      );

  Widget _bugListener({Widget child}) => BlocListener<BugBloc, BugState>(
        listener: (context, state) {
          if (state is ReadyBugState) _isBugReady = true;
          _navigateIfReady(context);
        },
        child: child,
      );

  void _navigateIfReady(BuildContext context) {
    if (_isFishReady && _isBugReady) {
      _isFishReady = false;
      _isBugReady = false;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => FishListPage()),
      );
    }
  }

  /*
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
      */
}
