import 'package:acnh/common/my_drawer.dart';
import 'package:acnh/data/fish.dart';
import 'package:acnh/module.dart';
import 'package:flutter/material.dart';

class FishPage extends StatefulWidget {
  @override
  _FishPageState createState() => _FishPageState();
}

class _FishPageState extends State<FishPage> {
  Future<List<Fish>> _getFishes;

  @override
  void initState() {
    super.initState();

    _getFishes = modules.fishRepository.getFishes();
  }

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
        body: FutureBuilder<List<Fish>>(
          future: _getFishes,
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      _listViewItem(snapshot.data[index]),
                  separatorBuilder: (context, index) => Container(),
                )
              : Center(child: CircularProgressIndicator()),
        ),
      );

  Widget _listViewItem(Fish fish) => ListTile(
        leading: Image.network(fish.imageUri),
        title: Text("Test"),
      );
}
