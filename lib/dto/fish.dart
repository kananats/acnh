import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Fish with EquatableMixin {
  int id;
  String name;

  String location;
  String shadow;
  int price;

  List<int> monthArrayNorthern;

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
    @required this.monthArrayNorthern,
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
        location: json["location"],
        shadow: json["shadow"],
        monthArrayNorthern:
            json["availability"]["month-array-northern"].cast<int>(),
        price: json["price"],
        imageUri: json["image_uri"],
        iconUri: json["icon_uri"],
      );
}

extension FishExtension on Fish {
  String get monthArray => monthArrayNorthern.toString();
}
