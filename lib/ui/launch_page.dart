import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/bug/bug_bloc.dart';
import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/bloc/fossil/fossil_bloc.dart';
import 'package:acnh/bloc/sea/sea_bloc.dart';
import 'package:acnh/bloc/villager/villager_bloc.dart';
import 'package:acnh/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> with BlocProviderMixin {
  bool _isVillagerReady = false;
  bool _isFishReady = false;
  bool _isBugReady = false;
  bool _isSeaReady = false;
  bool _isFossilReady = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _villagerListener(
          child: _fishListener(
            child: _bugListener(
              child: _seaListener(
                child: _fossilListener(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _villagerListener({Widget child}) =>
      BlocListener<VillagerBloc, VillagerState>(
        listener: (context, state) {
          if (state is ReadyVillagerState) _isVillagerReady = true;
          _navigateIfReady(context);
        },
        child: child,
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

  Widget _seaListener({Widget child}) => BlocListener<SeaBloc, SeaState>(
        listener: (context, state) {
          if (state is ReadySeaState) _isSeaReady = true;
          _navigateIfReady(context);
        },
        child: child,
      );

  Widget _fossilListener({Widget child}) =>
      BlocListener<FossilBloc, FossilState>(
        listener: (context, state) {
          if (state is ReadyFossilState) _isFossilReady = true;
          _navigateIfReady(context);
        },
        child: child,
      );

  void _navigateIfReady(BuildContext context) {
    if (_isVillagerReady &&
        _isFishReady &&
        _isBugReady &&
        _isSeaReady &&
        _isFossilReady) {
      _isVillagerReady = false;
      _isFishReady = false;
      _isBugReady = false;
      _isSeaReady = false;
      _isFossilReady = false;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    }
  }
}
