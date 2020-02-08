import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/entity/recommend.dart';
import 'package:wuhan2020_flutter_app/entity/rumor.dart';
import 'package:wuhan2020_flutter_app/entity/sickness_response.dart';
import 'package:wuhan2020_flutter_app/entity/timeline.dart';
import 'package:wuhan2020_flutter_app/entity/wiki_data.dart';
import 'package:wuhan2020_flutter_app/model/sickness_view_model.dart';

class SicknessProvider with ChangeNotifier {
  SicknessViewModel viewModel;
  RefreshController refreshController;
  SicknessResponse _response;
  int confirmedCount = 0;
  int suspectedCount = 0;
  int curedCount = 0;
  int deadCount = 0;
  bool refreshFailed = false;

  SicknessProvider({this.viewModel, this.refreshController}) {
    //refresh();
  }

  List getProvinceStats() {
    return viewModel?.getProvinceStats();
  }

  int getProvinceCount() {
    return _response == null
        ? 0
        : (_response.data == null
            ? 0
            : (_response.data.getAreaStat == null
                ? 0
                : _response.data.getAreaStat.length));
  }

  caculateCount() {
    confirmedCount = 0;
    suspectedCount = 0;
    curedCount = 0;
    deadCount = 0;
    for (var item in _response.data.getAreaStat) {
      confirmedCount += item.confirmedCount;
      suspectedCount += item.suspectedCount;
      curedCount += item.curedCount;
      deadCount += item.deadCount;
    }
  }

  WikiData getWikiData() {
    return _response?.data?.getWikiList;
  }

  List<Rumor> getRumorList() {
    return _response?.data?.getIndexRumorList;
  }

  List<Recommend> getRecommendList() {
    return _response?.data?.getIndexRecommendList;
  }

  List<Timeline> getTimelineList() {
    return _response?.data?.getTimelineService;
  }

  Future refresh() async {
    print("refresh:$viewModel,$refreshController");
    _response = await viewModel.loadData(0);
    if (_response == null || _response.errorCode != 0) {
      refreshFailed = true;
      refreshController?.refreshCompleted();
      notifyListeners();
      return;
    }
    refreshFailed = false;
    if (_response != null &&
        _response.data != null &&
        _response.data.getAreaStat.length > 0) {
      caculateCount();
      refreshController?.refreshCompleted();
    } else {
      refreshController?.loadNoData();
    }

    notifyListeners();
  }

  Future loadMore() async {
    refreshController?.loadNoData();

    notifyListeners();
  }
}
