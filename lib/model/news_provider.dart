import 'package:flutter/material.dart';
import 'package:flutter_base/log/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/entity/news.dart';
import 'package:wuhan2020_flutter_app/entity/news_data.dart';
import 'package:wuhan2020_flutter_app/entity/news_response.dart';
import 'package:wuhan2020_flutter_app/model/news_view_model.dart';

class NewsProvider with ChangeNotifier {
  NewsViewModel viewModel;
  RefreshController refreshController;
  NewsData _newsData = NewsData();
  List<News> data = [];
  List<News> _cacheData = [];

  NewsProvider({this.viewModel, this.refreshController}) {
    //refresh();
  }

  List getNews() {
    return data;
  }

  int getNewsCount() {
    return data == null ? 0 : data.length;
  }

  Future refresh() async {
    print("refresh:$viewModel,$refreshController");
    int startPage = 1;
    NewsResponse _response = await viewModel.loadData(startPage);
    if (null != _response && _response.data != null) {
      _newsData.isLastPage = _response.data.isLastPage;
      _newsData.hasNextPage = _response.data.hasNextPage;
      viewModel.setPage(startPage);
      if (_response.data.list.length > 0) {
        data = _response.data.list;
        if (_cacheData != null && _cacheData.length > 0) {
          News first = _cacheData[0];
          Logger.d("first:$first");
          for (var item in data) {
            Logger.d("time:$item");
            if (item.sendTime == first.sendTime &&
                item.sourceId == first.sourceId) {
              break;
            }
            item.isNew = true;
          }
        }
        _cacheData = data;
        refreshController?.refreshCompleted();
      } else {
        refreshController?.refreshFailed();
      }
    } else {
      data = [];
      refreshController?.loadNoData();
    }

    notifyListeners();
  }

  Future loadFromCache() async {
    print("loadFromCache:$viewModel,$refreshController");
    NewsResponse _response = await viewModel.loadFromCache();
    if (null != _response && _response.data != null) {
      _newsData.isLastPage = _response.data.isLastPage;
      _newsData.hasNextPage = _response.data.hasNextPage;
      if (_response.data.list.length > 0) {
        _cacheData = data = _response.data.list;
        refreshController?.refreshCompleted();
      }
    }

    notifyListeners();
    refreshController?.requestRefresh();
  }

  Future loadMore() async {
    if (!_newsData.hasNextPage) {
      refreshController?.resetNoData();
      notifyListeners();
      return;
    }
    NewsResponse _response = await viewModel.loadData(viewModel.page + 1);
    if (_response.data != null && _response.data.list.length > 0) {
      data ??= [];
      data.addAll(_response.data.list);
      viewModel.setPage(viewModel.page + 1);

      refreshController?.refreshCompleted();
    } else {
      if (_response.code == 200) {
        refreshController?.resetNoData();
      } else {
        refreshController?.loadFailed();
      }
    }

    notifyListeners();
  }
}
