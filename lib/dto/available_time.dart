import 'dart:convert';

import 'package:flutter/material.dart';

class AvailableTime {
  List<int> times;

  AvailableTime({@required this.times});

  factory AvailableTime.fromJson(dynamic json) => AvailableTime(
        times: json.cast<int>(),
      );

  factory AvailableTime.fromMap(dynamic map) => AvailableTime(
        times: json.decode(map).cast<int>(),
      );

  String toMap() => times.toString();

  @override
  String toString() => _formatTimeList(times).join(", ");

  static List<String> _formatTimeList(List<int> times) {
    if (times.isEmpty) return [];
    if (times.length >= 12) return ["All day"];

    List<String> result = [];
    var from = times[0];
    var to = times[0];

    for (int index = 1; index <= times.length; index++) {
      if (index >= times.length) {
        result.add("$from:00~$to:59");
        break;
      }

      int month = times[index];
      if (to + 1 == month) {
        to = month;
        continue;
      }

      result.add("$from:00~$to:59");
      from = month;
      to = month;
    }
    return result;
  }
}
