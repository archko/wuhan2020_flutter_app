import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class FileInfo {
  FileInfo(this.file, {this.validTill, this.originalUrl});

  String originalUrl;
  File file;
  DateTime validTill;
}

class FileHelper {
  FileHelper();

  static getFilePath(String name) async {
    List<Directory> _externalCacheDirectories =
        await getExternalCacheDirectories();
    //for (var d in _externalCacheDirectories) {
    //  Logger.d("dir:${d.path}");
    //}
    if (_externalCacheDirectories != null &&
        _externalCacheDirectories.length > 0) {
      return p.join(_externalCacheDirectories[0].path, name);
    }
  }

  static Future<String> getFileContent(String path) async {
    var file = File(path);
    var data;
    if (await file.exists()) {
      data = file.readAsStringSync();
    }
    return data;
  }

  static putFile(String path, String content) async {
    var file = File(path);
    file.writeAsString(content);
  }

  static Future<bool> isFileExists(String path) async {
    return File(path).exists();
  }
}
