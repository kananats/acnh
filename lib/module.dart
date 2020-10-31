import 'package:acnh/dao/fish_dao.dart';
import 'package:acnh/data/db.dart';
import 'package:acnh/repository/fish_repository.dart';
import 'package:acnh/repository/file_repository.dart';

var modules = Modules();

class Modules {
  // Data
  final LocalStorage localStorage = LocalStorage();

  // DAO
  final FishDao fishDao = FishDao();

  // Repository
  final FishRepository fishRepository = FishRepository();
  final FileRepository fileRepository = FileRepository();
}

mixin DaoProviderMixin {
  FishDao get fishDao => modules.fishDao;
}
