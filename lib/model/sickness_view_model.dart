import 'package:flutter/foundation.dart';
import 'package:wuhan2020_flutter_app/entity/sickness_response.dart';
import 'package:wuhan2020_flutter_app/http/http_client.dart';
import 'package:wuhan2020_flutter_app/http/http_response.dart';
import 'package:wuhan2020_flutter_app/model/base_list_view_model.dart';
import 'package:wuhan2020_flutter_app/utils/json_utils.dart';

class SicknessViewModel extends BaseListViewModel<SicknessResponse> {
  SicknessResponse _response;

  int getCount() {
    return _response == null
        ? 0
        : (_response.data == null
            ? 0
            : (_response.data.getAreaStat == null
                ? 0
                : _response.data.getAreaStat.length));
  }

  List getProvinceStats() {
    return _response == null
        ? null
        : (_response.data == null ? null : _response.data.getAreaStat);
  }

  Future<SicknessResponse> loadData(int pn, {String type}) async {
    String url =
        'https://service-0gg71fu4-1252957949.gz.apigw.tencentcs.com/release/dingxiangyuan';
    try {
      HttpResponse httpResponse = await HttpClient.instance.get(url);
      String result = httpResponse.data;
      _response = await compute(decodeListResult, result);
      print("result:$_response");
    } catch (e) {
      print(e);
    }
    return _response;
  }

  Future<SicknessResponse> loadMore(int pn) async {
    return null;
  }

  static SicknessResponse decodeListResult(String result) {
    //return json.decode(data);
    return SicknessResponse.fromJson(JsonUtils.decodeAsMap(result));
  }
}
