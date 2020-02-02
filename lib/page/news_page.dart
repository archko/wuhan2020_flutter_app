import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wuhan2020_flutter_app/model/news_view_model.dart';
import 'package:wuhan2020_flutter_app/page/base_list_state.dart';
import 'package:wuhan2020_flutter_app/page/news_item.dart';
import 'package:wuhan2020_flutter_app/widget/list/pull_widget.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewsPageState();
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
    refreshController = new RefreshController(initialRefresh: true);
    viewModel = new NewsViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Future refresh() async {
    viewModel.setPage(startPage);
    await (viewModel as NewsViewModel)
        .loadData(viewModel.page)
        .then((trending) {
      setState(() {
        print("refresh end.${viewModel.page}, ${viewModel.getCount()}");
        if (trending.data == null || trending.data.list.length < 1) {
          refreshController.loadNoData();
        } else {
          refreshController.refreshCompleted(resetFooterState: true);
        }
      });
    }).catchError((e) => setState(() {
              print("refresh error,$e");
              refreshController.loadFailed();
            }));
  }

  @override
  Future<void> loadMore() async {
    if (viewModel.getCount() < 1) {
      return refresh();
    }
    NewsViewModel hotViewModel = (viewModel as NewsViewModel);
    await hotViewModel.loadMore(hotViewModel.page + 1).then((trending) {
      setState(() {
        if (trending.data == null || trending.data.list.length < 1) {
          refreshController.loadNoData();
        } else {
          refreshController.refreshCompleted(resetFooterState: true);
        }
        print(
            "loadMore end.${refreshController.footerStatus},${viewModel.page}, ${viewModel.getCount()}");
      });
    }).catchError((e) => setState(() {
          print("loadMore error:$e");
          refreshController.loadFailed();
        }));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PullWidget(
        pullController: refreshController,
        listCount: (viewModel as NewsViewModel).getCount(),
        itemBuilder: (BuildContext context, int index) =>
            _renderItem(context, index),
        header: MaterialClassicHeader(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.HideAlways,
        ),
        onLoadMore: loadMore,
        onRefresh: refresh,
      ),
    );
  }

  //列表的ltem
  _renderItem(context, index) {
    return NewsItem(bean: (viewModel as NewsViewModel).getNews()[index]);
  }
}
