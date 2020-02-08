import 'package:wuhan2020_flutter_app/entity/news.dart';

class NewsData {
  int pageNum;
  int pageSize;
  int size;
  int startRow;
  int endRow;
  int total;
  int pages;
  List<News> list;
  bool isLastPage;
  bool hasNextPage;

  NewsData();

  NewsData.fromJson(Map<String, dynamic> json) {
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    size = json['size'];
    startRow = json['startRow'];
    endRow = json['endRow'];
    total = json['total'];
    pages = json['pages'];
    isLastPage = json['isLastPage'];
    hasNextPage = json['hasNextPage'];

    var results = json['list'];
    if (results != null) {
      list = results?.map<News>((item) => News.fromJson(item))?.toList() ?? [];
    }
  }

  @override
  String toString() {
    return 'NewsData{pageNum: $pageNum, pageSize: $pageSize, total: $total, hasNextPage: $hasNextPage, list: $list}';
  }
}
