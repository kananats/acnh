import 'package:acnh/module.dart';
import 'package:acnh/repository/file_repository.dart';
import 'package:acnh/repository/fish_repository.dart';

mixin RepositoryProviderMixin {
  FileRepository get fileRepository => modules.fileRepository;
  FishRepository get fishRepository => modules.fishRepository;
}
