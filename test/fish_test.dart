import 'dart:convert';

import 'package:acnh/dto/fish.dart';
import 'package:acnh/module.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("fetch fishs", () async {
    Response<String> response =
        await Dio().get("https://acnhapi.com/v1/fish/1");
    var fish = Fish.fromJson(json.decode(response.data));
    expect(fish.id, 1);
    expect(fish.fileName, "bitterling");
    expect(fish.name.USen, "bitterling");
    expect(fish.name.EUen, "bitterling");
    expect(fish.name.EUde, "Bitterling");
    expect(fish.name.USes, "amarguillo");
    expect(fish.name.EUfr, "bouvière");
    expect(fish.name.USfr, "bouvière");
    expect(fish.name.EUit, "rodeo");
    expect(fish.name.EUnl, "bittervoorn");
    expect(fish.name.CNzh, "红目鲫");
    expect(fish.name.TWzh, "紅目鯽");
    expect(fish.name.JPja, "タナゴ");
    expect(fish.name.KRko, "납줄개");
    expect(fish.name.EUru, "горчак");
    expect(fish.availability.location, "River");
    expect(fish.availability.rarity, "Common");
    expect(fish.availability.monthArrayNorthern, [11, 12, 1, 2, 3]);
    expect(fish.availability.monthArraySouthern, [5, 6, 7, 8, 9]);
    expect(fish.availability.timeArray, [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23
    ]);
    expect(fish.shadow, "Smallest (1)");
    expect(fish.price, 900);
    expect(fish.catchPhrase,
        "I caught a bitterling! It's mad at me, but only a little.");
    expect(fish.museumPhrase,
        "Bitterlings hide their eggs inside large bivalves—like clams—where the young can stay safe until grown. The bitterling isn't being sneaky. No, their young help keep the bivalve healthy by eating invading parasites! It's a wonderful bit of evolutionary deal making, don't you think? Each one keeping the other safe... Though eating parasites does not sound like a happy childhood... Is that why the fish is so bitter?");
    expect(fish.imageUri, "https://acnhapi.com/v1/images/fish/1");
    expect(fish.iconUri, "https://acnhapi.com/v1/icons/fish/1");
  });

  test("insert fish to db", () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // TODO: not working for some reason
    //await modules.localStorage.deleteDatabase();
    //await modules.fishDao.insert(fish);
    //var fishs = await modules.fishDao.findAll();
    //expect(fishs, []);
  });
}
