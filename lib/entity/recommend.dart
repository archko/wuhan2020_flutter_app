class Recommend {
  int id;
  int createTime;
  int modifyTime;
  int contentType;
  String title;
  String imgUrl;
  String linkUrl;
  int recordStatus;
  int sort;
  String operator;

  Recommend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['createTime'];
    modifyTime = json['modifyTime'];
    contentType = json['contentType'];
    title = json['title'];
    imgUrl = json['imgUrl'];
    linkUrl = json['linkUrl'];
    recordStatus = json['recordStatus'];
    sort = json['sort'];
    operator = json['operator'];
  }

  @override
  String toString() {
    return 'Recommend{id: $id, createTime: $createTime, modifyTime: $modifyTime, contentType: $contentType, title: $title, imgUrl: $imgUrl, linkUrl: $linkUrl, recordStatus: $recordStatus, sort: $sort, operator: $operator}';
  }
}
