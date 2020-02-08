import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/log/logger.dart';
import 'package:flutter_base/model/base_list_view_model.dart';
import 'package:flutter_base/utils/json_utils.dart';
import 'package:wuhan2020_flutter_app/common/file_helper.dart';
import 'package:wuhan2020_flutter_app/entity/sickness_response.dart';

class SicknessViewModel extends BaseListViewModel<SicknessResponse> {
  static const sickness_cache = "sickness_cache";
  SicknessResponse _response;

  int getCount() {
    return _response == null
        ? 0
        : (_response.data == null
            ? 0
            : (_response.data.getAreaStat == null
                ? 0
                : _response.data.getAreaStat.length));
  }

  List getProvinceStats() {
    return _response == null
        ? null
        : (_response.data == null ? null : _response.data.getAreaStat);
  }

  Future<SicknessResponse> loadData(int pn) async {
    String url =
        'https://service-0gg71fu4-1252957949.gz.apigw.tencentcs.com/release/dingxiangyuan';
    try {
      HttpResponse httpResponse = await HttpClient.instance.get(url);
      String result = httpResponse.data;
      _response = await compute(decodeListResult, result);

      if (_response != null) {
        saveToCache(result);
      }
      //print("result:$_response");
    } catch (e) {
      print(e);
    }
    return _response;
  }

  Future<SicknessResponse> loadMore(int pn) async {
    return null;
  }

  static SicknessResponse decodeListResult(String result) {
    //return json.decode(data);
    return SicknessResponse.fromJson(JsonUtils.decodeAsMap(result));
  }

  Future<SicknessResponse> loadFromCache() async {
    try {
      String path = await FileHelper.getFilePath(sickness_cache);
      String result = await FileHelper.getFileContent(path);
      Logger.d("cache:$path,result:${result != null}");
      if (result != null) {
        _response = await compute(decodeListResult, result);
      }
    } catch (e) {
      Logger.e("loadFromCache .e:$e");
    }
    return _response;
  }

  static saveToCache(String content) async {
    String path = await FileHelper.getFilePath(sickness_cache);
    Logger.d("putFile:$path");
    if (File(path).exists() != null) {
      FileHelper.putFile(path, content);
    }
  }
}
