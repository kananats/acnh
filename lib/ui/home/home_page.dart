import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/bug/bug_bloc.dart';
import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/bloc/sea/sea_bloc.dart';
import 'package:acnh/ui/bug/bug_list_page.dart';
import 'package:acnh/ui/common/my_drawer.dart';
import 'package:acnh/ui/fish/fish_list_page.dart';
import 'package:acnh/ui/home/home_card.dart';
import 'package:acnh/ui/sea/sea_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: MyDrawer(),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: [
            Row(
              children: [
                Expanded(
                  child: _fish(),
                ),
                Expanded(
                  child: _bug(),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _sea(),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _fish() => BlocBuilder<FishBloc, FishState>(
        builder: (context, state) {
          if (state is ReadyFishState)
            return GestureDetector(
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => FishListPage(),
                ),
              ),
              child: HomeCard(
                "Fish",
                caught: state.fishs.where((element) => element.isCaught).length,
                donated:
                    state.fishs.where((element) => element.isDonated).length,
                total: state.fishs.length,
              ),
            );
          return Container();
        },
      );

  Widget _bug() => BlocBuilder<BugBloc, BugState>(
        builder: (context, state) {
          if (state is ReadyBugState)
            return GestureDetector(
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => BugListPage(),
                ),
              ),
              child: HomeCard(
                "Bug",
                caught: state.bugs.where((element) => element.isCaught).length,
                donated:
                    state.bugs.where((element) => element.isDonated).length,
                total: state.bugs.length,
              ),
            );
          return Container();
        },
      );

  Widget _sea() => BlocBuilder<SeaBloc, SeaState>(
        builder: (context, state) {
          if (state is ReadySeaState)
            return GestureDetector(
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => SeaListPage(),
                ),
              ),
              child: HomeCard(
                "Sea Creature",
                caught: state.seas.where((element) => element.isCaught).length,
                donated:
                    state.seas.where((element) => element.isDonated).length,
                total: state.seas.length,
              ),
            );
          return Container();
        },
      );
}
