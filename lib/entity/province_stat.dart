import 'package:wuhan2020_flutter_app/entity/city_stat.dart';

class ProvinceStat {
  String provinceName;
  String provinceShortName;
  int confirmedCount;
  int suspectedCount;
  int curedCount;
  int deadCount;
  int locationId;
  String comment;
  List<CityStat> cities;

  ProvinceStat.fromJson(Map<String, dynamic> json) {
    provinceName = json['provinceName'];
    provinceShortName = json['provinceShortName'];
    confirmedCount = json['confirmedCount'];
    suspectedCount = json['suspectedCount'];
    curedCount = json['curedCount'];
    deadCount = json['deadCount'];
    locationId = json['locationId'];
    comment = json['comment'];
    var results = json['cities'];
    cities =
        results?.map<CityStat>((item) => CityStat.fromJson(item))?.toList() ??
            [];
  }

  @override
  String toString() {
    return 'ProvinceStat{provinceName: $provinceName, provinceShortName: $provinceShortName, confirmedCount: $confirmedCount, suspectedCount: $suspectedCount, curedCount: $curedCount, deadCount: $deadCount, locationId: $locationId, cities: $cities}';
  }
}
