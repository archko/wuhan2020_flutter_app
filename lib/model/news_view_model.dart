import 'package:flutter/foundation.dart';
import 'package:wuhan2020_flutter_app/entity/news_response.dart';
import 'package:wuhan2020_flutter_app/http/http_client.dart';
import 'package:wuhan2020_flutter_app/http/http_response.dart';
import 'package:wuhan2020_flutter_app/model/base_list_view_model.dart';
import 'package:wuhan2020_flutter_app/utils/json_utils.dart';

class NewsViewModel extends BaseListViewModel<NewsResponse> {
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
    String url = 'http://ncov.news.dragon-yuan.me/api/news/query?search=&page=$pn';
    try {
      HttpResponse httpResponse = await HttpClient.instance.get(url);
      String result = httpResponse.data;
      _response = await compute(decodeListResult, result);
      print("result:$_response");
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
}
