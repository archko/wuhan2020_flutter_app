class News {
  String sourceId;
  String url;
  String content;
  String sendTime;
  String fromName;

  News.fromJson(Map<String, dynamic> json) {
    sourceId = json['sourceId'];
    url = json['url'];
    content = json['content'];
    sendTime = json['sendTime'];
    fromName = json['fromName'];
  }

  @override
  String toString() {
    return 'News{sourceId: $sourceId, url: $url, content: $content, sendTime: $sendTime, fromName: $fromName}';
  }
}
