import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/entity/recommend.dart';
import 'package:wuhan2020_flutter_app/entity/wiki.dart';
import 'package:wuhan2020_flutter_app/entity/wiki_data.dart';

class RecommendPage extends StatefulWidget {
  final List<Recommend> recommendList;

  RecommendPage({Key key, this.recommendList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RecommendPageState();
  }

  @override
  String toStringShort() {
    return '劝告';
  }
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  RefreshController refreshController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("initState");
    refreshController = new RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: false,
        enablePullUp: false,
        controller: refreshController,
        header: MaterialClassicHeader(),
        footer: ClassicFooter(),
        child: ListView.builder(
          itemCount: widget.recommendList.length,
          itemBuilder: (BuildContext context, int index) =>
              _renderItem(context, index, widget.recommendList),
        ),
      ),
    );
  }

  _renderItem(context, index, list) {
    return RecommendItem(bean: list[index]);
  }
}

class RecommendItem extends StatelessWidget {
  RecommendItem({this.bean}) : super();
  final Recommend bean;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 4.0, left: 4.0, right: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text('${bean.title}',
              style: TextStyle(fontSize: 15.0, color: Colors.green)),
          Container(
            margin: const EdgeInsets.all(5.0),
            child: Image(
              image: CachedNetworkImageProvider('${bean.imgUrl}'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
