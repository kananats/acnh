import 'package:acnh/module.dart';
import 'package:acnh/repository/file_repository.dart';
import 'package:acnh/repository/fish_repository.dart';
import 'package:acnh/repository/setting_repository.dart';

mixin RepositoryProviderMixin {
  FileRepository get fileRepository => modules.fileRepository;
  SettingRepository get settingRepository => modules.settingRepository;
  FishRepository get fishRepository => modules.fishRepository;
}
