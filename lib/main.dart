import 'package:flutter/material.dart';
import 'package:wuhan2020_flutter_app/page/news/news_page.dart';
import 'package:wuhan2020_flutter_app/page/sickness/sickness_page.dart';
import 'package:wuhan2020_flutter_app/widget/tabs/tab_bar_widget.dart';

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
      title: 'Flutter provider',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TabBarPageWidget(
        tabViews: tabViews,
        title: '武汉加油',
      ),
    );
  }
}
