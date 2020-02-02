import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return '维基百科';
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
    return Scaffold(
      body: SmartRefresher(
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
    return Card(
      margin: const EdgeInsets.only(bottom: 4.0, left: 4.0, right: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text('${bean.title}',
              style: TextStyle(fontSize: 15.0, color: Colors.green)),
          Text('确认:${bean.description}'),
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
