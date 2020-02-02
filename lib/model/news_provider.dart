import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/entity/news.dart';
import 'package:wuhan2020_flutter_app/entity/news_data.dart';
import 'package:wuhan2020_flutter_app/entity/news_response.dart';
import 'package:wuhan2020_flutter_app/model/news_view_model.dart';

class NewsProvider with ChangeNotifier {
  NewsViewModel viewModel;
  RefreshController refreshController;
  NewsData _newsData;
  List<News> data = [];

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
    if (_response.data != null) {
      viewModel.setPage(startPage);
      if (_response.data.list.length > 0) {
        data = _response.data.list;
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

  Future loadMore() async {
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
