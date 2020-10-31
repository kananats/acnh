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
          ],
        ),
      );

  Widget _fish(BuildContext context) => ListTile(
        title: Text("Fish"),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => FishPage(),
          ));
        },
      );

  Widget _setting(BuildContext context) => ListTile(
        title: Text("Setting"),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => SettingPage(),
          ));
        },
      );
}
