import 'package:flutter/material.dart';
import 'package:flutter_base/widget/browser.dart';

class GatherPage extends StatefulWidget {
  GatherPage({Key key}) : super(key: key);

  @override
  _GatherPageState createState() => _GatherPageState();

  @override
  String toStringShort() {
    return '其它平台';
  }
}

class _GatherPageState extends State<GatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(shrinkWrap: true, children: <Widget>[
        InkWell(
          child: Card(
              color: Colors.indigo[300],
              child: Padding(
                child: Text(
                  "百度",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
              )),
          onTap: () {
            Browser.open(context,
                "https://voice.baidu.com/act/newpneumonia/newpneumonia",
                title: "百度", waitingTxt: "请稍候...");
          },
        ),
        InkWell(
          child: Card(
              color: Colors.indigo[300],
              child: Padding(
                child: Text(
                  "阿里健康",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
              )),
          onTap: () {
            Browser.open(context,
                "https://alihealth.taobao.com/medicalhealth/influenzamap?spm=a2oua.wuhaninfo.more.wenzhen&chInfo=spring2020-stay-in",
                title: "阿里健康", waitingTxt: "请稍候...");
          },
        ),
        InkWell(
          child: Card(
              color: Colors.purple[300],
              child: Padding(
                child: Text(
                  "第一财经",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
              )),
          onTap: () {
            Browser.open(context, "https://m.yicai.com/news/100476965.html",
                title: "第一财经", waitingTxt: "请稍候...");
          },
        ),
        InkWell(
          child: Card(
              color: Colors.orange[300],
              child: Padding(
                child: Text(
                  "腾讯",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
              )),
          onTap: () {
            Browser.open(context, "https://news.qq.com/zt2020/page/feiyan.htm",
                title: "腾讯", waitingTxt: "请稍候...");
          },
        ),
        InkWell(
          child: Card(
              color: Colors.teal[300],
              child: Padding(
                child: Text(
                  "新浪",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
              )),
          onTap: () {
            Browser.open(context, "https://news.sina.cn/zt_d/yiqing0121",
                title: "新浪", waitingTxt: "请稍候...");
          },
        ),
        InkWell(
          child: Card(
              color: Colors.amber[200],
              child: Padding(
                child: Text(
                  "梅斯",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
              )),
          onTap: () {
            Browser.open(context, "http://m.medsci.cn/wh.asp",
                title: "梅斯", waitingTxt: "请稍候...");
          },
        ),
        InkWell(
          child: Card(
              color: Colors.cyan[300],
              child: Padding(
                child: Text(
                  "丁香园",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
              )),
          onTap: () {
            Browser.open(context, "https://3g.dxy.cn/newh5/view/pneumonia",
                title: "丁香园", waitingTxt: "请稍候...");
          },
        ),
        InkWell(
          child: Card(
              color: Colors.teal[200],
              child: Padding(
                child: Text(
                  "知乎",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
              )),
          onTap: () {
            Browser.open(context, "https://www.zhihu.com/special/19681091",
                title: "知乎", waitingTxt: "请稍候...");
          },
        ),
      ]),
    );
  }
}
