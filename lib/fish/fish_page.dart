import 'dart:io';

import 'package:acnh/common/my_drawer.dart';
import 'package:acnh/fish/fish.dart';
import 'package:acnh/fish/fish_filter.dart';
import 'package:acnh/fish/fish_filter_condition.dart';
import 'package:acnh/module.dart';
import 'package:acnh/extension/string_extension.dart';

import 'package:flutter/material.dart';

class FishPage extends StatefulWidget {
  @override
  _FishPageState createState() => _FishPageState();
}

class _FishPageState extends State<FishPage> {
  Future<List<Fish>> _getFishes;
  FishFilterCondition _condition = FishFilterCondition();

  @override
  void initState() {
    super.initState();

    _getFishes = modules.fishRepository.getFishes();
    //_getFishes.then((value) => _fishes = value);
    //_getFishes.then((value) => _isSelected = value.map((e) => false));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              child: Icon(Icons.article),
              onTap: () => _showFishFilter(context),
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
                        padding: EdgeInsets.all(12),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) =>
                            _listViewItem(snapshot.data[index]),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      );

  Widget _listViewItem(Fish fish) => Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlue[300]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: SizedBox(
                height: 50,
                width: 50,
                child: Image.file(File(fish.iconUri)),
              ),
              title: Text(fish.name.capitalized()),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey[700],
                      ),
                      SizedBox(width: 4),
                      Text("Mar ~ Sep"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timelapse,
                        size: 16,
                        color: Colors.grey[700],
                      ),
                      SizedBox(width: 4),
                      Text("9AM ~ 12AM"),
                    ],
                  ),
                ],
              ),
              isThreeLine: true,
              trailing: Column(
                children: [
                  RaisedButton(
                    child: Text("Caught"),
                    onPressed: () => _setCaught(fish),
                  ),
                ],
              ),
              //subtitle: Text(fis),
            ),
          ),
          Positioned(
            left: -10,
            top: -10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 24,
              ),
            ),
          )
        ],
      );

  Future<void> _showFishFilter(BuildContext context) async {
    var condition = await showGeneralDialog<FishFilterCondition>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => FishFilter(),
    );

    if (condition != null)
      setState(
        () => _condition = condition,
      );
  }

  Future<void> _setCaught(Fish fish) async {
    fish.isCaught = true;
    await modules.fishRepository.updateFish(fish);
    setState(() {});
  }
}
