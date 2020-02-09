import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/interceptor/http_header_interceptor.dart';
import 'package:flutter_base/http/interceptor/http_log_interceptor.dart';
import 'package:flutter_base/log/logger.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuhan2020_flutter_app/page/home/home_tabs_page.dart';
import 'package:wuhan2020_flutter_app/page/news/news_page.dart';
import 'package:wuhan2020_flutter_app/page/sickness/sickness_page.dart';

void main() {
  HttpClient.instance.addInterceptor(HttpLogInterceptor());
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
    super.initState();
    _hasRequestedPermission().then((value) {
      hasRequest = value == null ? false : value;
    });
  }

  @override
  Widget build(BuildContext context) {
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

  _setHasRequestPermission() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('has_requested_permission', true);
  }

  Future<bool> _hasRequestedPermission() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get('has_requested_permission');
  }

  //permissions:[PermissionGroup.location],{PermissionGroup.location: PermissionStatus.denied, PermissionGroup.locationAlways: PermissionStatus.denied, PermissionGroup.locationWhenInUse: PermissionStatus.denied}
  //permissions:[PermissionGroup.storage]
  _requestPermission() async {
    await requestPermission(PermissionGroup.storage, "存储");
    await requestPermission(PermissionGroup.location, "定位");
    hasRequest = true;
    _setHasRequestPermission();
    setState(() {});
  }

  Future<void> requestPermission(
      PermissionGroup permission, String name) async {
    final List<PermissionGroup> permissions = <PermissionGroup>[permission];
    final Map<PermissionGroup, PermissionStatus> permissionRequestResult =
        await PermissionHandler().requestPermissions(permissions);

    Logger.d("permissions:$permissions,result:$permissionRequestResult");
    var _permissionStatus = permissionRequestResult[permission];

    if (_permissionStatus == PermissionStatus.granted) {
      Fluttertoast.showToast(msg: "${name}权限申请通过");
    } else {
      Fluttertoast.showToast(msg: "${name}权限申请被拒绝");
    }
  }
}

/*PermissionGroup.values
  .where((PermissionGroup permission) {
    if (Platform.isIOS) {
      return permission != PermissionGroup.unknown &&
          permission != PermissionGroup.sms &&
          permission != PermissionGroup.storage &&
          permission !=
              PermissionGroup.ignoreBatteryOptimizations &&
          permission != PermissionGroup.access_media_location;
    } else {
      return permission != PermissionGroup.unknown &&
          permission != PermissionGroup.mediaLibrary &&
          permission != PermissionGroup.photos &&
          permission != PermissionGroup.reminders;
    }
  })
  .map((PermissionGroup permission) =>
      CPermissionWidget(permission))
  .toList()*/
class PermissionWidget extends StatefulWidget {
  const PermissionWidget(this._permissionGroup);

  final PermissionGroup _permissionGroup;

  @override
  _PermissionState createState() => _PermissionState(_permissionGroup);
}

class _PermissionState extends State<PermissionWidget> {
  _PermissionState(this._permissionGroup);

  final PermissionGroup _permissionGroup;
  PermissionStatus _permissionStatus = PermissionStatus.unknown;

  @override
  void initState() {
    super.initState();

    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() {
    final Future<PermissionStatus> statusFuture =
        PermissionHandler().checkPermissionStatus(_permissionGroup);

    statusFuture.then((PermissionStatus status) {
      setState(() {
        _permissionStatus = status;
      });
    });
  }

  Color getPermissionColor() {
    switch (_permissionStatus) {
      case PermissionStatus.denied:
        return Colors.red;
      case PermissionStatus.granted:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_permissionGroup.toString()),
      subtitle: Text(
        _permissionStatus.toString(),
        style: TextStyle(color: getPermissionColor()),
      ),
      trailing: IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            checkServiceStatus(context, _permissionGroup);
          }),
      onTap: () {
        requestPermission(_permissionGroup);
      },
    );
  }

  void checkServiceStatus(BuildContext context, PermissionGroup permission) {
    PermissionHandler()
        .checkServiceStatus(permission)
        .then((ServiceStatus serviceStatus) {
      final SnackBar snackBar =
          SnackBar(content: Text(serviceStatus.toString()));

      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  Future<void> requestPermission(PermissionGroup permission) async {
    final List<PermissionGroup> permissions = <PermissionGroup>[permission];
    final Map<PermissionGroup, PermissionStatus> permissionRequestResult =
        await PermissionHandler().requestPermissions(permissions);

    setState(() {
      print(permissionRequestResult);
      _permissionStatus = permissionRequestResult[permission];
      print(_permissionStatus);
    });
  }
}
