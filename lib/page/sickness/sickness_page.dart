import 'package:flutter/material.dart';
import 'package:flutter_base/model/base_list_state.dart';
import 'package:flutter_base/model/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/common/channel/analytics_channel.dart';
import 'package:wuhan2020_flutter_app/entity/province_stat.dart';
import 'package:wuhan2020_flutter_app/model/sickness_provider.dart';
import 'package:wuhan2020_flutter_app/model/sickness_view_model.dart';
import 'package:wuhan2020_flutter_app/page/sickness/sickness_city_list_page.dart';
import 'package:wuhan2020_flutter_app/page/sickness/sickness_province_list_item.dart';

class SicknessPage extends StatefulWidget {
  SicknessPage({Key key, this.sicknessProvider}) : super(key: key);
  final SicknessProvider sicknessProvider;

  @override
  State<StatefulWidget> createState() {
    return _SicknessPageState(parentProvider: sicknessProvider);
  }

  @override
  String toStringShort() {
    return '病例';
  }
}

class _SicknessPageState extends State<SicknessPage>
    with BaseListState<SicknessPage>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  SicknessProvider parentProvider;

  _SicknessPageState({Key key, this.parentProvider}) : super();

  @override
  void initState() {
    super.initState();
    print("initState:$parentProvider");
    refreshController = new RefreshController(initialRefresh: false);
    if (parentProvider == null) {
      parentProvider = SicknessProvider(
          viewModel: SicknessViewModel(), refreshController: refreshController);
    } else {
      parentProvider.refreshController = refreshController;
    }
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
    if (parentProvider != null && parentProvider.getProvinceCount() > 0) {
      return buildWidgetWithData(parentProvider);
    } else {
      return buildWidget();
    }
  }

  ProviderWidget<SicknessProvider> buildWidget() {
    return ProviderWidget<SicknessProvider>(
      model: parentProvider,
      onModelInitial: (m) {
        //refreshController.requestRefresh();
      },
      builder: (context, model, childWidget) {
        return buildWidgetWithData(model);
      },
    );
  }

  Widget buildWidgetWithData(SicknessProvider model) {
    List<Widget> grids = <Widget>[
      Column(
        children: <Widget>[
          Text('确诊', style: TextStyle(fontSize: 14.0, color: Colors.red)),
          Divider(
            thickness: 2,
            color: Colors.transparent,
          ),
          Text('${model.confirmedCount}',
              style: TextStyle(fontSize: 14.0, color: Colors.red)),
        ],
      ),
      Column(
        children: <Widget>[
          Text('疑似',
              style: TextStyle(fontSize: 14.0, color: Colors.pinkAccent)),
          Divider(
            thickness: 2,
            color: Colors.transparent,
          ),
          Text('${model.suspectedCount}',
              style: TextStyle(fontSize: 14.0, color: Colors.pinkAccent)),
        ],
      ),
      Column(
        children: <Widget>[
          Text('死亡', style: TextStyle(fontSize: 14.0, color: Colors.black)),
          Divider(
            thickness: 2,
            color: Colors.transparent,
          ),
          Text('${model.deadCount}',
              style: TextStyle(fontSize: 14.0, color: Colors.black)),
        ],
      ),
      Column(
        children: <Widget>[
          Text('治愈', style: TextStyle(fontSize: 14.0, color: Colors.green)),
          Divider(
            thickness: 2,
            color: Colors.transparent,
          ),
          Text('${model.curedCount}',
              style: TextStyle(fontSize: 14.0, color: Colors.green)),
        ],
      ),
    ];
    List<Widget> widgets = <Widget>[
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.only(
              left: 4.0, top: 4.0, right: 4.0, bottom: 8.0),
          child: Text('全国疫情',
              style: TextStyle(fontSize: 16.0, color: Colors.black)),
        ),
      ),
      SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 2,
            mainAxisSpacing: 0,
            childAspectRatio: 1.3),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return grids[index];
          },
          childCount: 4,
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.only(
              left: 4.0, top: 4.0, right: 4.0, bottom: 8.0),
          child: Text('国内疫情',
              style: TextStyle(fontSize: 16.0, color: Colors.black)),
        ),
      ),
      SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 1),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _renderItem(context, index, model.getProvinceStats());
          },
          childCount: model.getProvinceCount(),
        ),
      ),
    ];
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
        //child: GridView.builder(
        //  primary: false,
        //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //      crossAxisCount: 2,
        //      crossAxisSpacing: 4,
        //      mainAxisSpacing: 4,
        //      childAspectRatio: 1),
        //  itemCount: model.getProvinceCount(),
        //  itemBuilder: (BuildContext context, int index) =>
        //      _renderItem(context, index, model.getProvinceStats()),
        //),
        child: CustomScrollView(
          slivers: widgets,
        ),
      ),
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
    return SicknessProvinceItem(
      bean: provinceStats[index],
      onPressed: () {
        detail(provinceStats[index]);
      },
    );
  }

  void detail(ProvinceStat provinceStat) {
    Map<String, String> map = Map();
    map["page"] = "province_detail";
    map["page_cities"] = provinceStat.provinceName;
    AnalyticsChannel.post(map);
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return SicknessCityListPage(
            provinceStat: provinceStat,
          );
        },
      ),
    );
  }
}
