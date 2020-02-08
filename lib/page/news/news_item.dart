import 'package:flutter/material.dart';
import 'package:flutter_base/widget/browser.dart';
import 'package:wuhan2020_flutter_app/entity/news.dart';

class NewsItem extends StatelessWidget {
  NewsItem({this.bean}) : super();
  final News bean;

  void detail(String bean) {}

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        child: InkResponse(
          highlightShape: BoxShape.rectangle,
          radius: 300.0,
          highlightColor: Color(0x11000000),
          onTap: () {
            Browser.open(context, bean.url,
                title: bean.fromName, waitingTxt: "请稍候...");
          },
          child: Card(
            margin: const EdgeInsets.only(
                bottom: 4.0, left: 4.0, right: 4.0, top: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin:
                      const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${bean.fromName}:${bean.sendTime}',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: bean.isNew ? Colors.red : Colors.blue)),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                      child: Text("${bean.content}",
                          style: TextStyle(fontSize: 15.0))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
