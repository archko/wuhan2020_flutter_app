import 'package:wuhan2020_flutter_app/page/news/news_page.dart';
import 'package:wuhan2020_flutter_app/page/sickness/sickness_page.dart';
import 'package:wuhan2020_flutter_app/widget/tabs/tab_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeTabsPage extends StatelessWidget {
  final List<Widget> tabViews = [
    new SicknessPage(),
    new NewsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '武汉加油',
      home: new TabBarPageWidget(
        tabViews: tabViews,
        title: '武汉加油',
      ),
    );
  }
}
