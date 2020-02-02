import 'package:flutter/material.dart';
import 'package:wuhan2020_flutter_app/entity/news.dart';

class NewsItem extends StatelessWidget {
  NewsItem({this.bean, this.onPressed}) : super();
  final News bean;
  final VoidCallback onPressed;

  void detail(String bean) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${bean.fromName}:${bean.sendTime}'),
                ],
              ),
            ),
            Container(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                  child: Text("${bean.content}",
                      style: TextStyle(fontSize: 15.0, color: Colors.blue))),
            ),
          ],
        ),
      ),
    );
  }
}
