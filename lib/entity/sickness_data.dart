import 'package:wuhan2020_flutter_app/entity/province_stat.dart';
import 'package:wuhan2020_flutter_app/entity/recommend.dart';
import 'package:wuhan2020_flutter_app/entity/rumor.dart';
import 'package:wuhan2020_flutter_app/entity/timeline.dart';
import 'package:wuhan2020_flutter_app/entity/wiki.dart';
import 'package:wuhan2020_flutter_app/entity/wiki_data.dart';

class SicknessData {
  List<ProvinceStat> getAreaStat;
  List<Recommend> getIndexRecommendList;
  List<Rumor> getIndexRumorList;
  List<Timeline> getTimelineService;
  WikiData getWikiList;

  SicknessData.fromJson(Map<String, dynamic> json) {
    var results = json['getAreaStat'];
    if (results != null) {
      getAreaStat = results
              ?.map<ProvinceStat>((item) => ProvinceStat.fromJson(item))
              ?.toList() ??
          [];
    }
    results = json['getIndexRecommendList'];
    if (results != null) {
      getIndexRecommendList = results
              ?.map<Recommend>((item) => Recommend.fromJson(item))
              ?.toList() ??
          [];
    }
    results = json['getIndexRumorList'];
    if (results != null) {
      getIndexRumorList =
          results?.map<Rumor>((item) => Rumor.fromJson(item))?.toList() ?? [];
    }
    results = json['getTimelineService'];
    if (results != null) {
      getTimelineService =
          results?.map<Timeline>((item) => Timeline.fromJson(item))?.toList() ??
              [];
    }
    results = json['getWikiList'];
    if (results != null) {
      getWikiList = WikiData.fromJson(results);
    }
  }

  @override
  String toString() {
    return 'SicknessData{getAreaStat: $getAreaStat, getIndexRecommendList: $getIndexRecommendList, getIndexRumorList: $getIndexRumorList, getTimelineService: $getTimelineService}';
  }
}
