import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileRepository {
  Future<String> download(String url) async {
    var directory = await getApplicationDocumentsDirectory();
    var path = "${directory.path}/downloads/$url";
    await Dio().download(url, path);
    return path;
  }

  Future<String> downloadImage(String url) async {
    var directory = await getApplicationDocumentsDirectory();
    var imageUrl = url.replaceAll("https://", "downloads/");
    var path = "${directory.path}/$imageUrl.png";
    await Dio().download(url, path);
    return path;
  }

  Future<bool> exists(String path) async {
    if (path == null || path.isEmpty) return false;
    return await File(path).exists();
  }
}
