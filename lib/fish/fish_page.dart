import 'package:acnh/common/my_drawer.dart';
import 'package:acnh/fish/fish.dart';
import 'package:acnh/fish/fish_filter.dart';
import 'package:acnh/module.dart';
import 'package:acnh/extension/string_extension.dart';

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
              child: Icon(Icons.article),
              onTap: () => showGeneralDialog(
                context: context,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FishFilter(),
              ),
            ),
            SizedBox(width: 12),
          ],
        ),
        drawer: MyDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Fish>>(
              future: _getFishes,
              builder: (context, snapshot) => snapshot.hasData
                  ? Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) =>
                            _listViewItem(snapshot.data[index]),
                        separatorBuilder: (context, index) => Container(),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      );

  Widget _listViewItem(Fish fish) => Container(
        //color: Colors.green,
        child: ListTile(
          leading: SizedBox(
            height: 50,
            width: 50,
            child: Image.network(fish.iconUri),
          ),
          title: Text(fish.name.capitalized()),
          //subtitle: Text(fis),
        ),
      );
}
