import 'dart:io';

import 'package:acnh/common/download_dialog.dart';
import 'package:acnh/fish/fish_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acnh/common/my_drawer.dart';
import 'package:acnh/fish/fish.dart';
import 'package:acnh/fish/fish_bloc.dart';
import 'package:acnh/fish/fish_filter_dialog.dart';
import 'package:acnh/fish/fish_filter_condition.dart';
import 'package:acnh/fish/fish_state.dart';
import 'package:acnh/module.dart';
import 'package:acnh/extension/string_extension.dart';

class FishPage extends StatefulWidget {
  @override
  _FishPageState createState() => _FishPageState();
}

class _FishPageState extends State<FishPage> with FishBlocProviderMixin {
  FishFilterCondition _condition = FishFilterCondition();

  @override
  void initState() {
    super.initState();

    fishBloc.add(InitializeFishEvent());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              child: Icon(Icons.cloud_download),
              onTap: () => _showDownloadDialog(context),
            ),
            SizedBox(width: 18),
            GestureDetector(
              child: Icon(Icons.article),
              onTap: () => _showFilterDialog(context),
            ),
            SizedBox(width: 18),
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
            BlocBuilder<FishBloc, FishState>(
              builder: (context, state) {
                if (state is SuccessFishState)
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(12),
                      itemCount: state.fishs.length,
                      itemBuilder: (context, index) =>
                          _listViewItem(state.fishs[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12),
                    ),
                  );
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
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

  Future<void> _showDownloadDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => DownloadDialog(),
    );

    setState(() {});
  }

  Future<void> _showFilterDialog(BuildContext context) async {
    var condition = await showGeneralDialog<FishFilterCondition>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          FishFilterDialog(),
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
