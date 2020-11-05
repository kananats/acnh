import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:tuple/tuple.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:acnh/modules.dart';
import 'package:acnh/dao/dao.dart';
import 'package:acnh/data/get_fishs.dart';
import 'package:acnh/data/preferences.dart';
import 'package:acnh/dto/language_enum.dart';
import 'package:acnh/dto/fish.dart';
import 'package:acnh/dto/fish_filter_condition.dart';
import 'package:acnh/dto/setting.dart';

part 'file_repository.dart';
part 'setting_repository.dart';
part 'fish_repository.dart';

mixin RepositoryProviderMixin {
  FileRepository get fileRepository => modules.fileRepository;
  SettingRepository get settingRepository => modules.settingRepository;
  FishRepository get fishRepository => modules.fishRepository;
}
