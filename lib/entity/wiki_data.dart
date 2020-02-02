import 'package:wuhan2020_flutter_app/entity/wiki.dart';

class WikiData {
  int pageNum;
  int pageSize;
  int total;
  List<Wiki> result;

  WikiData.fromJson(Map<String, dynamic> json) {
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    total = json['total'];

    var results = json['result'];
    if (results != null) {
      result =
          results?.map<Wiki>((item) => Wiki.fromJson(item))?.toList() ?? [];
    }
  }

  @override
  String toString() {
    return 'WikiData{pageNum: $pageNum, pageSize: $pageSize, total: $total, result: $result}';
  }
}
