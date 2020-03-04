import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/widget/browser.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/entity/wiki.dart';
import 'package:wuhan2020_flutter_app/entity/wiki_data.dart';

class WikiPage extends StatefulWidget {
  final WikiData wikiData;

  WikiPage({Key key, this.wikiData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WikiPageState();
  }

  @override
  String toStringShort() {
    return '症状/预防';
  }
}

class _WikiPageState extends State<WikiPage>
    with AutomaticKeepAliveClientMixin {
  RefreshController refreshController;
  List<Wiki> _wikiList;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("initState");
    _wikiList = widget.wikiData.result;
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
          itemCount: _wikiList.length,
          itemBuilder: (BuildContext context, int index) =>
              _renderItem(context, index, _wikiList),
        ),
      ),
    );
  }

  _renderItem(context, index, list) {
    return WikiItem(bean: list[index]);
  }
}

class WikiItem extends StatelessWidget {
  WikiItem({this.bean}) : super();
  final Wiki bean;

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
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('${bean.title}',
                      style: TextStyle(fontSize: 15.0, color: Colors.green)),
                  Text('${bean.description}'),
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
      ),
    );
  }
}
