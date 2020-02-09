import 'dart:collection';

import 'package:wuhan2020_flutter_app/common/channel/dart_channel.dart';

class AnalyticsChannel {
  static Future<dynamic> post(Map params) async {
    Map args = HashMap();
    args['method'] = 'analytics';
    if (null != params) {
      args['params'] = params;
    }
    return DartChannel.singleton.invokeMethod(ANALYTICS_REQUEST, args);
  }

  static const ANALYTICS_REQUEST = "analytics_request";
}
