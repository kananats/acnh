import 'package:acnh/ui/bug/bug_page.dart';
import 'package:acnh/ui/fish/fish_page.dart';
import 'package:acnh/ui/setting_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          children: [
            _fish(context),
            _bug(context),
            Divider(),
            _setting(context),
            _about(context),
          ],
        ),
      );

  Widget _fish(BuildContext context) => ListTile(
        title: Text("Fish"),
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => FishPage(),
          ));
        },
      );

  Widget _bug(BuildContext context) => ListTile(
        title: Text("Bug"),
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => BugPage(),
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
