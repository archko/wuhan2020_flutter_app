import 'package:flutter/material.dart';
import 'package:flutter_base/model/provider_widget.dart';
import 'package:flutter_base/widget/tabs/tab_bar_widget.dart';
import 'package:wuhan2020_flutter_app/common/channel/analytics_channel.dart';
import 'package:wuhan2020_flutter_app/entity/recommend.dart';
import 'package:wuhan2020_flutter_app/entity/rumor.dart';
import 'package:wuhan2020_flutter_app/entity/wiki_data.dart';
import 'package:wuhan2020_flutter_app/model/sickness_provider.dart';
import 'package:wuhan2020_flutter_app/model/sickness_view_model.dart';
import 'package:wuhan2020_flutter_app/page/gather_page.dart';
import 'package:wuhan2020_flutter_app/page/news/news_page.dart';
import 'package:wuhan2020_flutter_app/page/recommend/recommend_page.dart';
import 'package:wuhan2020_flutter_app/page/rumor/rumor_page.dart';
import 'package:wuhan2020_flutter_app/page/sickness/sickness_page.dart';
import 'package:wuhan2020_flutter_app/page/wiki/wiki_page.dart';

class HomeTabsPage extends StatefulWidget {
  HomeTabsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeTabsPageState();
  }

  @override
  String toStringShort() {
    return '';
  }
}

class _HomeTabsPageState extends State<HomeTabsPage> {
  final List<Widget> tabViews = [
    SicknessPage(),
    NewsPage(),
  ];
  SicknessProvider _sicknessProvider;

  @override
  void initState() {
    super.initState();
    print("initState");
    _sicknessProvider = SicknessProvider(viewModel: new SicknessViewModel());
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SicknessProvider>(
      model: _sicknessProvider,
      onModelInitial: (m) {
        m.loadFromCache();
        //m.refresh();
      },
      builder: (context, model, childWidget) {
        Widget widget;
        if (model.hasResponse()) {
          widget = initTabs(widget);
        } else {
          if (model.refreshFailed) {
            tabViews.clear();
            tabViews.add(GatherPage());
            widget = TabBarPageWidget(
              tabViews: tabViews,
              title: '武汉加油',
              tabClick: (int index, String name) {
                Map<String, String> map = Map();
                map["page"] = "page_tab";
                map["tab_index"] = index.toString();
                map["tab_name"] = name;

                AnalyticsChannel.post(map);
              },
            );
          } else if (model.getProvinceCount() == 0) {
            widget = Scaffold(
              appBar: AppBar(
                title: Text('武汉加油'),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            widget = initTabs(widget);
          }
        }
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: widget,
        );
      },
    );
  }

  Widget initTabs(Widget widget) {
    tabViews.clear();
    tabViews.add(SicknessPage(
      sicknessProvider: _sicknessProvider,
    ));
    tabViews.add(GatherPage());
    tabViews.add(NewsPage());
    WikiData wikiData = _sicknessProvider.getWikiData();
    if (wikiData != null &&
        wikiData.result != null &&
        wikiData.result.length > 0) {
      tabViews.add(WikiPage(
        wikiData: wikiData,
      ));
    }

    List<Rumor> rumors = _sicknessProvider.getRumorList();
    if (rumors != null && rumors.length > 0) {
      tabViews.add(RumorPage(rumorList: _sicknessProvider.getRumorList()));
    }

    List<Recommend> recommendList = _sicknessProvider.getRecommendList();
    if (recommendList != null && recommendList.length > 0) {
      tabViews.add(
          RecommendPage(recommendList: _sicknessProvider.getRecommendList()));
    }

    widget = TabBarPageWidget(
      tabViews: tabViews,
      title: '武汉加油',
      tabClick: (int index, String name) {
        Map<String, String> map = Map();
        map["page"] = "page_tab";
        map["tab_index"] = index.toString();
        map["tab_name"] = name;

        AnalyticsChannel.post(map);
      },
    );
    return widget;
  }
}
