import 'dart:async';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
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
}
