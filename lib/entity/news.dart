class News {
  String sourceId;
  String url;
  String sendTime;
  String content;
  String fromName;
  bool isNew = false;

  News.fromJson(Map<String, dynamic> json) {
    sourceId = json['sourceId'];
    url = json['url'];
    sendTime = json['sendTime'];
    content = json['content'];
    fromName = json['fromName'];
  }

  @override
  String toString() {
    return 'News{sourceId: $sourceId, url: $url, sendTime: $sendTime, content: $content, fromName: $fromName, isNew: $isNew}';
  }
}
