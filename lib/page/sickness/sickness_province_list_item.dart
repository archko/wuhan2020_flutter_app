import 'package:flutter/material.dart';
import 'package:wuhan2020_flutter_app/entity/province_stat.dart';

class SicknessProvinceItem extends StatelessWidget {
  SicknessProvinceItem({this.bean, this.onPressed}) : super();
  final ProvinceStat bean;
  final VoidCallback onPressed;

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
            onPressed();
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 4.0, left: 4.0, right: 4.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 4.0),
                    height: 150.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('${bean.provinceName}',
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.green)),
                        Text('确认:${bean.confirmedCount}',
                            style: TextStyle(color: Colors.red)),
                        Text('疑似:${bean.suspectedCount}'),
                        Text('治愈:${bean.curedCount}',
                            style: TextStyle(color: Colors.green)),
                        Text('死亡:${bean.deadCount}',
                            style: TextStyle(color: Colors.red)),
                        Text('${bean.comment}',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.red)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
