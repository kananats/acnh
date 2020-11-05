import 'package:acnh/dao/dao.dart';
import 'package:acnh/data/clock.dart';
import 'package:acnh/data/db.dart';
import 'package:acnh/repository/repository.dart';

var modules = Modules();

class Modules {
  // Data
  final LocalStorage localStorage = LocalStorage();
  final Clock clock = Clock();

  // DAO
  final FishDao fishDao = FishDao();

  // Repository
  final FileRepository fileRepository = FileRepository();
  final SettingRepository settingRepository = SettingRepository();
  final FishRepository fishRepository = FishRepository();
}
