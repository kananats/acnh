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
  final VillagerDao villagerDao = VillagerDao();
  final FishDao fishDao = FishDao();
  final BugDao bugDao = BugDao();
  final SeaDao seaDao = SeaDao();

  // Repository
  final FileRepository fileRepository = FileRepository();
  final SettingRepository settingRepository = SettingRepository();
  final VillagerRepository villagerRepository = VillagerRepository();
  final FishRepository fishRepository = FishRepository();
  final BugRepository bugRepository = BugRepository();
  final SeaRepository seaRepository = SeaRepository();
}
