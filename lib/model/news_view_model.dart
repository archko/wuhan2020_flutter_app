import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/log/logger.dart';
import 'package:flutter_base/model/base_list_view_model.dart';
import 'package:flutter_base/utils/json_utils.dart';
import 'package:wuhan2020_flutter_app/common/file_helper.dart';
import 'package:wuhan2020_flutter_app/entity/news_response.dart';

class NewsViewModel extends BaseListViewModel<NewsResponse> {
  static const news_cache = "news_cache";
  NewsResponse _response;

  NewsViewModel() {
    page = 1;
  }

  int getCount() {
    return _response == null
        ? 0
        : (_response.data == null
            ? 0
            : (_response.data.list == null ? 0 : _response.data.list.length));
  }

  List getNews() {
    return _response == null
        ? null
        : (_response.data == null ? null : _response.data.list);
  }

  Future<NewsResponse> loadData(int pn) async {
    pn ??= 1;
    String url = 'http://ncov.news.dragon-yuan.me/api/news?search=&page=$pn';
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

  Future<NewsResponse> loadMore(int pn) async {
    return loadData(pn);
  }

  static NewsResponse decodeListResult(String result) {
    //return json.decode(data);
    return NewsResponse.fromJson(JsonUtils.decodeAsMap(result));
  }

  Future<NewsResponse> loadFromCache() async {
    try {
      String path = await FileHelper.getFilePath(news_cache);
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
    String path = await FileHelper.getFilePath(news_cache);
    Logger.d("putFile:$path");
    if (File(path).exists() != null) {
      FileHelper.putFile(path, content);
    }
  }
}
