import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/entity/province_stat.dart';
import 'package:wuhan2020_flutter_app/model/base_list_state.dart';
import 'package:wuhan2020_flutter_app/model/provider_widget.dart';
import 'package:wuhan2020_flutter_app/model/sickness_provider.dart';
import 'package:wuhan2020_flutter_app/model/sickness_view_model.dart';
import 'package:wuhan2020_flutter_app/page/sickness/sickness_province_list_item.dart';

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
    refreshController = new RefreshController(initialRefresh: false);
    viewModel = new SicknessViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Future refresh() async {}

  @override
  Future<void> loadMore() async {}

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<SicknessProvider>(
      model: SicknessProvider(
          viewModel: viewModel, refreshController: refreshController),
      onModelInitial: (m) {
        m.refresh();
      },
      builder: (context, model, childWidget) {
        return Container(
          margin: EdgeInsets.all(4),
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: refreshController,
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            header: MaterialClassicHeader(),
            footer: ClassicFooter(
              loadStyle: LoadStyle.HideAlways,
            ),
            child: GridView.builder(
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 1),
              itemCount: model.getProvinceCount(),
              itemBuilder: (BuildContext context, int index) =>
                  _renderItem(context, index, model.getProvinceStats()),
            ),
          ),
        );
      },
    );
  }

  Widget buildList(List<ProvinceStat> provinceStats) {
    print("buildList:${provinceStats == null ? 0 : provinceStats.length}");
    return ListView.builder(
      itemCount: provinceStats == null ? 0 : provinceStats.length,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) =>
          _renderItem(context, index, provinceStats),
    );
  }

  //列表的ltem
  _renderItem(context, index, List<ProvinceStat> provinceStats) {
    return SicknessProvinceItem(bean: provinceStats[index]);
  }
}
