import 'package:acnh/home_page.dart';
import 'package:acnh/module.dart';
import 'package:flutter/material.dart';

class LoadPage extends StatefulWidget {
  @override
  _LoadPageState createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  Future<void> _fetch;

  @override
  void initState() {
    super.initState();

    _fetch = modules.fishRepository.fetch();
    _fetch.whenComplete(
      () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 12),
              Text("Initializing..."),
            ],
          ),
        ),
      );
}
