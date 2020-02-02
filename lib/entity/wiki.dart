class Wiki {
  int id;
  String title;
  String imgUrl;
  String linkUrl;
  String description;
  int sort;

  Wiki.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imgUrl = json['imgUrl'];
    linkUrl = json['linkUrl'];
    description = json['description'];
    sort = json['sort'];
  }

  @override
  String toString() {
    return 'Wiki{id: $id, title: $title, imgUrl: $imgUrl, linkUrl: $linkUrl, description: $description, sort: $sort}';
  }
}
