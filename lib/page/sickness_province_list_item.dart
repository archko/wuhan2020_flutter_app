import 'package:flutter/material.dart';
import 'package:wuhan2020_flutter_app/entity/province_stat.dart';

class SicknessProvinceItem extends StatelessWidget {
  SicknessProvinceItem({this.bean, this.onPressed}) : super();
  final ProvinceStat bean;
  final VoidCallback onPressed;

  void detail(String bean) {}

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: Row(
        children: <Widget>[
          ///Expanded(
          ///  flex: 2,
          ///  child: Container(
          ///    margin: const EdgeInsets.all(10.0),
          ///    child: ClipRRect(
          ///      borderRadius: BorderRadius.circular(10.0),
          ///      child: Image(
          ///        image: CachedNetworkImageProvider('${bean.kg_pic_url}'),
          ///        fit: BoxFit.cover,
          ///      ),
          ///    ),
          ///  ),
          ///),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(left: 10.0),
              height: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('${bean.provinceName}'),
                  Text('${bean.comment}',
                      style: TextStyle(fontSize: 15.0, color: Colors.blue)),
                  Text('确认:${bean.confirmedCount}'),
                  Text('疑似:${bean.suspectedCount}'),
                  Text('治愈:${bean.curedCount}'),
                  Text('死亡:${bean.deadCount}'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
