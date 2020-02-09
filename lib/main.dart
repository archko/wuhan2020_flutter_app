import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/interceptor/http_header_interceptor.dart';
import 'package:flutter_base/log/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wuhan2020_flutter_app/page/home/home_tabs_page.dart';
import 'package:wuhan2020_flutter_app/page/news/news_page.dart';
import 'package:wuhan2020_flutter_app/page/sickness/sickness_page.dart';
import 'package:wuhan2020_flutter_app/utils/permission_utils.dart';

void main() {
  //HttpClient.instance.addInterceptor(HttpLogInterceptor());
  HttpClient.instance.addInterceptor(HttpHeaderInterceptor());
  Logger.init(debuggable: true);
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

  bool hasRequest = false;

  @override
  void initState() {
    PermissionUtils.hasRequestedPermission().then((value) {
      hasRequest = value == null ? false : value;
      Logger.d("request:$hasRequest");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Logger.d("build:$hasRequest");
    Widget widget;
    if (hasRequest) {
      widget = HomeTabsPage();
    } else {
      widget = Scaffold(
        appBar: AppBar(
          title: Text('武汉加油'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
      _requestPermission();
    }

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //home: TabBarPageWidget(
      //  tabViews: tabViews,
      //  title: '武汉加油',
      //),
      home: widget,
    );
  }

  //permissions:[PermissionGroup.location],{PermissionGroup.location: PermissionStatus.denied, PermissionGroup.locationAlways: PermissionStatus.denied, PermissionGroup.locationWhenInUse: PermissionStatus.denied}
  //permissions:[PermissionGroup.storage]
  _requestPermission() async {
    await PermissionUtils.requestPermission(PermissionGroup.storage, "存储");
    await PermissionUtils.requestPermission(PermissionGroup.location, "定位");
    hasRequest = true;
    PermissionUtils.setHasRequestPermission();
    setState(() {});
  }
}
