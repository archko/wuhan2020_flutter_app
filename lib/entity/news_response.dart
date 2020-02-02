import 'package:wuhan2020_flutter_app/entity/news_data.dart';

class NewsResponse {
  int code;
  String message;

  NewsData data;

  NewsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];

    var results = json['result'];
    if (results != null) {
      data = NewsData.fromJson(results);
    }
  }

  @override
  String toString() {
    return 'NewsResponse{code: $code, message: $message, data: $data}';
  }
}
