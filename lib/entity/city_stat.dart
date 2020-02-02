class CityStat {
  String cityName;
  int confirmedCount;
  int suspectedCount;
  int curedCount;
  int deadCount;
  int locationId;

  CityStat.fromJson(Map<String, dynamic> json) {
    cityName = json['cityName'];
    confirmedCount = json['confirmedCount'];
    suspectedCount = json['suspectedCount'];
    curedCount = json['curedCount'];
    deadCount = json['deadCount'];
    locationId = json['locationId'];
  }

  @override
  String toString() {
    return 'CityStat{cityName: $cityName, confirmedCount: $confirmedCount, suspectedCount: $suspectedCount, curedCount: $curedCount, deadCount: $deadCount, locationId: $locationId}';
  }
}
