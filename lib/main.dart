import 'dart:io';

import 'package:acnh/load_page.dart';
import 'package:acnh/storage/file_manager.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "acnh",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoadPage(),
      );
}

// Test code goes here
class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();

    test();
  }

  void test() async {
    var path = await FileManager()
        .downloadImage("https://acnhapi.com/v1/images/fish/1");
    print(path);
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
