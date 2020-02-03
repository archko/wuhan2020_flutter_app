import 'package:flutter/material.dart';
import 'package:wuhan2020_flutter_app/page/home/home_tabs_page.dart';
import 'package:wuhan2020_flutter_app/page/news/news_page.dart';
import 'package:wuhan2020_flutter_app/page/sickness/sickness_page.dart';

void main() {
  runApp(WuhanApp());
}

class WuhanApp extends StatefulWidget {
  const WuhanApp({
    Key key,
  }) : super(key: key);

  @override
  _WuhanAppState createState() => _WuhanAppState();
}

class _WuhanAppState extends State<WuhanApp> {
  final List<Widget> tabViews = [
    new SicknessPage(),
    new NewsPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //home: TabBarPageWidget(
      //  tabViews: tabViews,
      //  title: '武汉加油',
      //),
      home: HomeTabsPage(),
    );
  }
}
