import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:acnh/data/api/api.dart';
import 'package:acnh/data/clock.dart';
import 'package:acnh/dto/bug.dart';
import 'package:acnh/dto/bug_filter_condition.dart';
import 'package:acnh/dto/fossil.dart';
import 'package:acnh/dto/fossil_filter_condition.dart';
import 'package:acnh/dto/sea.dart';
import 'package:acnh/dto/sea_filter_condition.dart';
import 'package:acnh/dto/villager.dart';
import 'package:acnh/dto/villager_filter_condition.dart';
import 'package:acnh/error/error.dart';
import 'package:tuple/tuple.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:acnh/modules.dart';
import 'package:acnh/dao/dao.dart';
import 'package:acnh/data/preferences.dart';
import 'package:acnh/dto/fish.dart';
import 'package:acnh/dto/fish_filter_condition.dart';
import 'package:acnh/dto/setting.dart';

part 'file_repository.dart';
part 'setting_repository.dart';
part 'villager_repository.dart';
part 'fish_repository.dart';
part 'bug_repository.dart';
part 'sea_repository.dart';
part 'fossil_repository.dart';

mixin RepositoryProviderMixin {
  FileRepository get fileRepository => modules.fileRepository;
  SettingRepository get settingRepository => modules.settingRepository;
  VillagerRepository get villagerRepository => modules.villagerRepository;
  FishRepository get fishRepository => modules.fishRepository;
  BugRepository get bugRepository => modules.bugRepository;
  SeaRepository get seaRepository => modules.seaRepository;
  FossilRepository get fossilRepository => modules.fossilRepository;
}
