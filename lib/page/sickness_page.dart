import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/model/sickness_view_model.dart';
import 'package:wuhan2020_flutter_app/page/base_list_state.dart';
import 'package:wuhan2020_flutter_app/page/sickness_province_list_item.dart';

class SicknessPage extends StatefulWidget {
  SicknessPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SicknessPageState();
  }
}

class _SicknessPageState extends State<SicknessPage>
    with BaseListState<SicknessPage>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("initState");
    refreshController = new RefreshController(initialRefresh: true);
    viewModel = new SicknessViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  Future<void> loadMore() async {
    refreshController.loadNoData();
  }

  @override
  Future refresh() async {
    viewModel.setPage(startPage);
    await (viewModel as SicknessViewModel)
        .loadData(viewModel.page)
        .then((trending) {
      setState(() {
        print("refresh end.${viewModel.page}, ${viewModel.getCount()}");
        if (trending.data == null || trending.data.getAreaStat.length < 1) {
          refreshController.loadNoData();
        } else {
          refreshController.refreshCompleted(resetFooterState: true);
        }
      });
    }).catchError((e) => setState(() {
              print("refresh error,$e");
              refreshController.loadFailed();
            }));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ///return PullWidget(
    ///  pullController: refreshController,
    ///  listCount: (viewModel as SicknessViewModel).getCount(),
    ///  itemBuilder: (BuildContext context, int index) =>
    ///      _renderItem(context, index),
    ///  header: MaterialClassicHeader(),
    ///  //onLoadMore: loadMore,
    ///  onRefresh: refresh,
    ///);
    return Container(
      margin: EdgeInsets.all(4),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: refreshController,
        onRefresh: refresh,
        header: MaterialClassicHeader(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.HideAlways,
        ),
        onLoading: loadMore,
        child: GridView.builder(
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 1),
          itemCount: (viewModel as SicknessViewModel).getCount(),
          itemBuilder: (BuildContext context, int index) =>
              _renderItem(context, index),
        ),
      ),
    );
  }

  //列表的ltem
  _renderItem(context, index) {
    return SicknessProvinceItem(
        bean: (viewModel as SicknessViewModel).getProvinceStats()[index]);
  }
}
