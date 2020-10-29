import 'package:acnh/db/db.dart';
import 'package:acnh/fish/fish_repository.dart';

var modules = Modules();

class Modules {
  LocalStorage localStorage = LocalStorage();
  FishRepository fishRepository = FishRepository();
}
