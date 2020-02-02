import 'package:flutter/material.dart';
import 'package:wuhan2020_flutter_app/entity/recommend.dart';
import 'package:wuhan2020_flutter_app/entity/rumor.dart';
import 'package:wuhan2020_flutter_app/entity/wiki_data.dart';
import 'package:wuhan2020_flutter_app/model/provider_widget.dart';
import 'package:wuhan2020_flutter_app/model/sickness_provider.dart';
import 'package:wuhan2020_flutter_app/model/sickness_view_model.dart';
import 'package:wuhan2020_flutter_app/page/news/news_page.dart';
import 'package:wuhan2020_flutter_app/page/recommend/recommend_page.dart';
import 'package:wuhan2020_flutter_app/page/rumor/rumor_page.dart';
import 'package:wuhan2020_flutter_app/page/sickness/sickness_page.dart';
import 'package:wuhan2020_flutter_app/page/wiki/wiki_page.dart';
import 'package:wuhan2020_flutter_app/widget/tabs/tab_bar_widget.dart';

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
        m.refresh();
      },
      builder: (context, model, childWidget) {
        if (model.getProvinceCount() == 0) {
          return Scaffold(
            body: Container(
              margin: EdgeInsets.all(30),
              alignment: Alignment.topCenter,
              child: RefreshProgressIndicator(),
            ),
          );
        } else {
          tabViews.clear();
          tabViews.add(SicknessPage(
            sicknessProvider: _sicknessProvider,
          ));
          tabViews.add(NewsPage());
          WikiData wikiData = _sicknessProvider.getWikiData();
          if (wikiData != null &&
              wikiData.result != null &&
              wikiData.result.length > 0) {
            tabViews.add(WikiPage(
              wikiData: wikiData,
            ));
          }

          List<Recommend> recommendList = _sicknessProvider.getRecommendList();
          if (recommendList != null && recommendList.length > 0) {
            tabViews.add(RecommendPage(
                recommendList: _sicknessProvider.getRecommendList()));
          }

          List<Rumor> rumors = _sicknessProvider.getRumorList();
          if (rumors != null && rumors.length > 0) {
            tabViews
                .add(RumorPage(rumorList: _sicknessProvider.getRumorList()));
          }

          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: TabBarPageWidget(
              tabViews: tabViews,
              title: '武汉加油',
            ),
          );
        }
      },
    );
  }
}
