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
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.lightBlue[300]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
          leading: SizedBox(child: _iconImage()),
          title: Text(capitalize(widget.fish.name)),
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
              children: [_caughtChip, _donatedChip],
            )
          ],
        ),
      );

  Row _price() {
    return Row(
      children: [
        Icon(
          Icons.call_missed_outgoing,
          size: 16,
        ),
        SizedBox(width: 4),
        Text("${widget.fish.price} Bells"),
      ],
    );
  }

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
              widget.fish.availableMonthNorth.toString(), // TODO
            ),
          ),
        ],
      );

  Image _iconImage() {
    return Image(
      width: 50,
      height: 50,
      image: widget.fish.iconPath != null
          ? FileImage(File(widget.fish.iconPath))
          : NetworkImage(widget.fish.iconUri),
    );
  }

  Widget get _caughtChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: true,
        onSelected: (hideDonated) => setState(() {}),
        label: Text(
          "Caught",
          style: TextStyle(fontSize: 12),
        ),
      );

  Widget get _donatedChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: true,
        onSelected: (hideDonated) => setState(() {}),
        label: Text(
          "Donated",
          style: TextStyle(fontSize: 12),
        ),
      );

  Future<void> _setCaught(Fish fish) async {
    fish.isCaught = !fish.isCaught;
    fishBloc.add(UpdateFishEvent(fish: fish));
    setState(() {});
  }
}
