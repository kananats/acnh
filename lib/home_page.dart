import 'package:acnh/common/my_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              child: Icon(Icons.refresh),
              onTap: () {},
            ),
            SizedBox(width: 12),
          ],
        ),
        drawer: MyDrawer(),
        body: Container(),
      );
}
