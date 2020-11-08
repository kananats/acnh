import 'package:flutter/material.dart';

import 'package:acnh/ui/setting_page.dart';
import 'package:acnh/ui/villager/villager_list_page.dart';
import 'package:acnh/ui/fish/fish_list_page.dart';
import 'package:acnh/ui/bug/bug_list_page.dart';
import 'package:acnh/ui/sea/sea_list_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          children: [
            _villager(context),
            Divider(),
            _fish(context),
            _bug(context),
            _sea(context),
            Divider(),
            _setting(context),
            _about(context),
          ],
        ),
      );

  Widget _villager(BuildContext context) => ListTile(
        title: Text("Villager"),
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => VillagerListPage(),
          ));
        },
      );

  Widget _fish(BuildContext context) => ListTile(
        title: Text("Fish"),
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => FishListPage(),
          ));
        },
      );

  Widget _bug(BuildContext context) => ListTile(
        title: Text("Bug"),
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => BugListPage(),
          ));
        },
      );

  Widget _sea(BuildContext context) => ListTile(
        title: Text("Sea Creatures"),
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => SeaListPage(),
          ));
        },
      );

  Widget _setting(BuildContext context) => ListTile(
        title: Text("Settings"),
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => SettingPage(),
          ));
        },
      );

  Widget _about(BuildContext context) => ListTile(
        title: Text("About"),
        onTap: () => showAboutDialog(
          context: context,
          applicationVersion: "0.0.1",
          applicationLegalese: """
Made by @mnrfromnano
API provided by http://acnhapi.com/
This app is in development. Things may break. Use at your own risk.

          """,
        ),
      );
}
