class Timeline {
  int id;
  int pubDate;
  String pubDateStr;
  String title;
  String summary;
  String infoSource;
  String sourceUrl;
  String provinceId;
  String provinceName;
  int createTime;
  int modifyTime;
  int entryWay;
  int adoptType;
  int infoType;
  int dataInfoState;
  String dataInfoOperator;
  int dataInfoTime;

  Timeline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pubDate = json['pubDate'];
    pubDateStr = json['pubDateStr'];
    title = json['title'];
    summary = json['summary'];
    infoSource = json['infoSource'];
    sourceUrl = json['sourceUrl'];
    provinceId = json['provinceId'];
    provinceName = json['provinceName'];
    createTime = json['createTime'];
    modifyTime = json['modifyTime'];
    entryWay = json['entryWay'];
    adoptType = json['adoptType'];
    infoType = json['infoType'];
    dataInfoState = json['dataInfoState'];
    dataInfoOperator = json['dataInfoOperator'];
    dataInfoTime = json['dataInfoTime'];
  }

  @override
  String toString() {
    return 'Timeline{pubDateStr: $pubDateStr, title: $title, summary: $summary, infoSource: $infoSource, provinceName: $provinceName}';
  }
}
