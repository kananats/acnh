import 'dart:io';

import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/fish/fish_event.dart';
import 'package:acnh/dto/fish.dart';
import 'package:acnh/ui/common/badge.dart';
import 'package:acnh/util/string_util.dart';
import 'package:flutter/material.dart';

class FishItem extends StatefulWidget {
  final Fish fish;
  final bool isVisible;

  FishItem({
    @required this.fish,
    this.isVisible,
  });

  @override
  _FishItemState createState() => _FishItemState();
}

class _FishItemState extends State<FishItem> with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => AnimatedCrossFade(
        duration: Duration(milliseconds: 300),
        firstCurve: Curves.fastOutSlowIn,
        sizeCurve: Curves.fastOutSlowIn,
        secondCurve: Curves.fastOutSlowIn,
        crossFadeState: widget.isVisible
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: Column(
          children: [
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlue[300]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                leading: Column(
                  children: [
                    SizedBox(child: _iconImage),
                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _name,
                    SizedBox(width: 6),
                    if (widget.fish.isAvailable(
                      timeBloc.state.dateTime,
                      fishBloc.condition.isNorth,
                    ))
                      _badge("Now"),
                    if (widget.fish.isCaught) _badge("Caught"),
                    if (widget.fish.isDonated) _badge("Donated"),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _location,
                    _availableMonth,
                    _availableTime,
                  ],
                ),
                children: [
                  ButtonBar(
                    children: [
                      _caughtChip,
                      _donatedChip,
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        secondChild: Container(),
      );

  Widget _badge(String text) => Row(
        children: [
          Badge(text),
          SizedBox(width: 3),
        ],
      );

  Widget get _name => Text(
        capitalize(widget.fish.name),
        style: TextStyle(color: Colors.blue),
      );

  Widget get _location => Row(
        children: [
          Icon(
            Icons.location_pin,
            size: 16,
          ),
          SizedBox(width: 4),
          Text(widget.fish.location),
        ],
      );

  Widget get _availableTime => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.timelapse,
            size: 16,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              widget.fish.availableTime.toString(),
            ),
          ),
        ],
      );

  Widget get _availableMonth => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.calendar_today,
            size: 16,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              widget.fish.availableMonth(fishBloc.condition.isNorth).toString(),
            ),
          ),
        ],
      );

  Widget get _iconImage => Image(
        width: 50,
        height: 50,
        image: widget.fish.iconPath != null
            ? FileImage(File(widget.fish.iconPath))
            : NetworkImage(widget.fish.iconUri),
      );

  Widget get _caughtChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.fish.isCaught,
        onSelected: (isCaught) {
          widget.fish.isCaught = !widget.fish.isCaught;
          fishBloc.add(UpdateFishEvent(fish: widget.fish));
          setState(() {});
        },
        label: Text(
          "Caught",
          style: TextStyle(fontSize: 12),
        ),
      );

  Widget get _donatedChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.fish.isDonated,
        onSelected: (isDonated) {
          widget.fish.isDonated = !widget.fish.isDonated;
          fishBloc.add(UpdateFishEvent(fish: widget.fish));
          setState(() {});
        },
        label: Text(
          "Donated",
          style: TextStyle(fontSize: 12),
        ),
      );
}
