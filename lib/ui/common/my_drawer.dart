import 'package:acnh/ui/fish/fish_page.dart';
import 'package:acnh/ui/setting_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          children: [
            _fish(context),
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
Things may break. 
Use at your own risk.
Made by @mnrfromnano
          """,
        ),
      );
}
