import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/entity/sickness_response.dart';
import 'package:wuhan2020_flutter_app/model/sickness_view_model.dart';

class SicknessProvider with ChangeNotifier {
  SicknessViewModel viewModel;
  RefreshController refreshController;
  SicknessResponse _response;

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

  Future refresh() async {
    print("refresh:$viewModel,$refreshController");
    _response = await viewModel.loadData(0);
    if (_response.data != null && _response.data.getAreaStat.length > 0) {
      var list = _response.data.getAreaStat;
      if (list != null && list.length > 0) {
        if (list.length < 1) {
          refreshController?.loadNoData();
        } else {
          refreshController?.refreshCompleted();
        }
      }
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
