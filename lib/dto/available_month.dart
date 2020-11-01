import 'dart:convert';

import 'package:flutter/material.dart';

class AvailableMonth {
  List<int> months;

  AvailableMonth({@required this.months});

  factory AvailableMonth.fromJson(dynamic json) => AvailableMonth(
        months: json.cast<int>(),
      );

  factory AvailableMonth.fromMap(dynamic map) => AvailableMonth(
        months: json.decode(map).cast<int>(),
      );

  String toMap() => months.toString();

  @override
  String toString() => _formatMonthList(months).join(", ");

  bool get isAllYear => months.length >= 12;

  static List<String> _formatMonthList(List<int> months) {
    if (months.isEmpty) return [];
    if (months.length >= 12) return ["All year"];

    List<String> result = [];
    var from = months[0];
    var to = months[0];

    for (int index = 1; index <= months.length; index++) {
      if (index >= months.length) {
        if (from == to)
          result.add(_monthToString(from));
        else
          result.add("${_monthToString(from)}~${_monthToString(to)}");
        break;
      }

      int month = months[index];
      if (to + 1 == month) {
        to = month;
        continue;
      }

      if (from == to)
        result.add(_monthToString(from));
      else
        result.add("${_monthToString(from)}~${_monthToString(to)}");

      from = month;
      to = month;
    }
    return result;
  }

  static List<String> _monthNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  static String _monthToString(int month) => _monthNames[month - 1];
}
