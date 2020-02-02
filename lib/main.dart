import 'package:flutter/material.dart';
import 'package:wuhan2020_flutter_app/page/home/home_tabs_page.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter provider',
      home: HomeTabsPage(),
    );
  }
}
