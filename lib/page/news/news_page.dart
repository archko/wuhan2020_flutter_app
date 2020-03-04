import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/model/base_list_state.dart';
import 'package:flutter_base/model/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/entity/news.dart';
import 'package:wuhan2020_flutter_app/model/news_provider.dart';
import 'package:wuhan2020_flutter_app/model/news_view_model.dart';
import 'package:wuhan2020_flutter_app/page/news/news_item.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewsPageState();
  }

  @override
  String toStringShort() {
    return '实时资讯';
  }
}

class _NewsPageState extends State<NewsPage>
    with BaseListState<NewsPage>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("initState");
    refreshController = new RefreshController(initialRefresh: false);
    viewModel = new NewsViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Future refresh() async {}

  @override
  Future<void> loadMore() async {}

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ProviderWidget<NewsProvider>(
      model: NewsProvider(
          viewModel: viewModel, refreshController: refreshController),
      onModelInitial: (m) {
        //refreshController.requestRefresh();
        m.loadFromCache();
      },
      builder: (context, model, childWidget) {
        return Container(
          margin: EdgeInsets.all(4),
          child: SmartRefresher(
            physics: BouncingScrollPhysics(),
            enablePullDown: true,
            enablePullUp: true,
            controller: refreshController,
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            header: MaterialClassicHeader(),
            footer: ClassicFooter(),
            child: ListView.builder(
              itemCount: model.getNewsCount(),
              itemBuilder: (BuildContext context, int index) =>
                  _renderItem(context, index, model.getNews()),
            ),
          ),
        );
      },
    );
  }

  Widget buildList(List<News> newList) {
    print("buildList:${newList == null ? 0 : newList.length}");
    return ListView.builder(
      itemCount: newList == null ? 0 : newList.length,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) =>
          _renderItem(context, index, newList),
    );
  }

  //列表的ltem
  _renderItem(context, index, newList) {
    return NewsItem(bean: newList[index]);
  }
}
