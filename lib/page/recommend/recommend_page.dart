import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/widget/browser.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/entity/recommend.dart';

class RecommendPage extends StatefulWidget {
  final List<Recommend> recommendList;

  RecommendPage({Key key, this.recommendList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RecommendPageState();
  }

  @override
  String toStringShort() {
    return '推荐阅读';
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
    super.build(context);
    return Scaffold(
      body: SmartRefresher(
        physics: BouncingScrollPhysics(),
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
    return Material(
      child: Ink(
        color: Color(0xFFFFFFFF),
        child: InkResponse(
          highlightShape: BoxShape.rectangle,
          radius: 300.0,
          highlightColor: Color(0x11000000),
          onTap: () {
            Browser.open(context, bean.linkUrl,
                title: bean.title, waitingTxt: "请稍候...");
          },
          child: Card(
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
          ),
        ),
      ),
    );
  }
}
