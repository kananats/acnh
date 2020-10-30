import 'package:acnh/storage/db.dart';
import 'package:acnh/fish/fish_repository.dart';
import 'package:acnh/storage/file_manager.dart';

var modules = Modules();

class Modules {
  // Storage
  final localStorage = LocalStorage();
  final fileManager = FileManager();

  // Repository
  final fishRepository = FishRepository();
}
