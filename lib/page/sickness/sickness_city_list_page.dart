import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/entity/city_stat.dart';
import 'package:wuhan2020_flutter_app/entity/province_stat.dart';

class SicknessCityListPage extends StatefulWidget {
  final ProvinceStat provinceStat;

  SicknessCityListPage({Key key, this.provinceStat}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SicknessCityListPageState();
  }
}

class _SicknessCityListPageState extends State<SicknessCityListPage> {
  RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    print("initState");
    refreshController = new RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.provinceStat.provinceName),
      ),
      body: SmartRefresher(
        enablePullDown: false,
        enablePullUp: false,
        controller: refreshController,
        header: MaterialClassicHeader(),
        footer: ClassicFooter(),
        //child: ListView.builder(
        //  itemCount: widget.provinceStat.cities.length,
        //  itemBuilder: (BuildContext context, int index) =>
        //      _renderItem(context, index, widget.provinceStat.cities),
        //),
        child: GridView.builder(
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 1),
          itemCount: widget.provinceStat.cities.length,
          itemBuilder: (BuildContext context, int index) =>
              _renderItem(context, index, widget.provinceStat.cities),
        ),
      ),
    );
  }

  _renderItem(context, index, list) {
    return SicknessCityItem(bean: list[index]);
  }
}

class SicknessCityItem extends StatelessWidget {
  SicknessCityItem({this.bean}) : super();
  final CityStat bean;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 4.0, left: 4.0, right: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 4.0),
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('${bean.cityName}',
                      style: TextStyle(fontSize: 15.0, color: Colors.green)),
                  Text('确认:${bean.confirmedCount}',
                      style: TextStyle(color: Colors.red)),
                  Text('疑似:${bean.suspectedCount}'),
                  Text('治愈:${bean.curedCount}',
                      style: TextStyle(color: Colors.green)),
                  Text('死亡:${bean.deadCount}',
                      style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
