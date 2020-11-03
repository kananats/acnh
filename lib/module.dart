import 'package:acnh/dao/fish_dao.dart';
import 'package:acnh/data/db.dart';
import 'package:acnh/repository/fish_repository.dart';
import 'package:acnh/repository/file_repository.dart';
import 'package:acnh/repository/setting_repository.dart';

var modules = Modules();

class Modules {
  // Data
  final LocalStorage localStorage = LocalStorage();

  // DAO
  final FishDao fishDao = FishDao();

  // Repository
  final FileRepository fileRepository = FileRepository();
  final SettingRepository settingRepository = SettingRepository();
  final FishRepository fishRepository = FishRepository();
}
