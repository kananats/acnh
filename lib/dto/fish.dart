import 'package:acnh/dto/available_month.dart';
import 'package:acnh/dto/available_time.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Fish with EquatableMixin {
  int id;
  String name;

  String location;
  String shadow;
  int price;

  AvailableMonth availableMonthNorth;
  AvailableMonth availableMonthSouth;
  AvailableTime availableTime;

  String imageUri;
  String iconUri;

  String imagePath;
  String iconPath;

  bool isCaught;
  bool isDonated;

  Fish({
    @required this.id,
    @required this.name,
    @required this.location,
    @required this.shadow,
    @required this.price,
    @required this.availableMonthNorth,
    @required this.availableMonthSouth,
    @required this.availableTime,
    @required this.imageUri,
    @required this.iconUri,
    this.imagePath,
    this.iconPath,
    this.isCaught = false,
    this.isDonated = false,
  });

  @override
  List<Object> get props => [id];

  factory Fish.fromJson(Map<String, dynamic> json) => Fish(
        id: json["id"],
        name: json["name"]["name-USen"],
        location: json["availability"]["location"],
        shadow: json["shadow"],
        availableMonthNorth: AvailableMonth.fromJson(
          json["availability"]["month-array-northern"],
        ),
        availableMonthSouth: AvailableMonth.fromJson(
          json["availability"]["month-array-southern"],
        ),
        availableTime: AvailableTime.fromJson(
          json["availability"]["time-array"],
        ),
        price: json["price"],
        imageUri: json["image_uri"],
        iconUri: json["icon_uri"],
      );
}

extension FishExtension on Fish {
  AvailableMonth availableMonth(bool isNorth) =>
      isNorth ? availableMonthNorth : availableMonthSouth;
}
