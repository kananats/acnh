import 'dart:io';

import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/fish_event.dart';
import 'package:acnh/dto/fish.dart';
import 'package:acnh/util/string_util.dart';
import 'package:flutter/material.dart';

class FishItem extends StatefulWidget {
  final Fish fish;

  FishItem({@required this.fish});

  @override
  _FishItemState createState() => _FishItemState();
}

class _FishItemState extends State<FishItem> with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => Stack(
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
                child: Image(
                  image: widget.fish.iconPath != null
                      ? FileImage(File(widget.fish.iconPath))
                      : NetworkImage(widget.fish.iconUri),
                ),
              ),
              title: Text(capitalize(widget.fish.name)),
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
                      Text(formatMonthList(widget.fish.monthArrayNorthern)
                          .toString()),
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
                      Text(widget.fish.monthArray),
                    ],
                  ),
                ],
              ),
              isThreeLine: true,
              trailing: Column(
                children: [
                  RaisedButton(
                    child: Text("Caught"),
                    onPressed: () => _setCaught(widget.fish),
                  ),
                ],
              ),
              //subtitle: Text(fis),
            ),
          ),
          if (widget.fish.isCaught)
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

  Future<void> _setCaught(Fish fish) async {
    fish.isCaught = !fish.isCaught;
    fishBloc.add(UpdateFishEvent(fish: fish));
    setState(() {});
  }
}
