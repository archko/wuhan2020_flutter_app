import 'package:wuhan2020_flutter_app/entity/sickness_data.dart';

class SicknessResponse {
  int errorCode;
  String errorMessage;
  bool ok;

  SicknessData data;

  SicknessResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    ok = json['ok'];

    var results = json['data'];
    if (results != null) {
      data = SicknessData.fromJson(results);
    }
  }

  @override
  String toString() {
    return 'SicknessResponse{errorCode: $errorCode, errorMessage: $errorMessage, ok: $ok, data: $data}';
  }
}
