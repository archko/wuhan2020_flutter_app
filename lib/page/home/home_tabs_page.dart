import 'package:wuhan2020_flutter_app/page/news_page.dart';
import 'package:wuhan2020_flutter_app/page/sickness_page.dart';
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
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new TabBarPageWidget(
        tabViews: tabViews,
      ),
    );
  }
}
