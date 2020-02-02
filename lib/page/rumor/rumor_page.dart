import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/entity/rumor.dart';

class RumorPage extends StatefulWidget {
  final List<Rumor> rumorList;

  RumorPage({Key key, this.rumorList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RumorPageState();
  }

  @override
  String toStringShort() {
    return '谣言';
  }
}

class _RumorPageState extends State<RumorPage>
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
          itemCount: widget.rumorList.length,
          itemBuilder: (BuildContext context, int index) =>
              _renderItem(context, index, widget.rumorList),
        ),
      ),
    );
  }

  _renderItem(context, index, list) {
    return RumorItem(bean: list[index]);
  }
}

class RumorItem extends StatelessWidget {
  RumorItem({this.bean}) : super();
  final Rumor bean;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('${bean.title}',
                style: TextStyle(fontSize: 15.0, color: Colors.green)),
            Text('${bean.mainSummary}'),
            Text('${bean.body}'),
          ],
        ),
      ),
    );
  }
}
