import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/news/news_detail/index.dart';
import 'package:wmn_plus/features/news/news_detail/widgets/news_details_item_body.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({
    Key key,
    @required NewsDetailBloc newsDetailBloc,
    String id,
  })  : _newsDetailBloc = newsDetailBloc,
        _id = id,
        super(key: key);

  final NewsDetailBloc _newsDetailBloc;
  final String _id;

  @override
  NewsDetailScreenState createState() {
    return new NewsDetailScreenState(_newsDetailBloc);
  }
}

class NewsDetailScreenState extends State<NewsDetailScreen> {
  final NewsDetailBloc _newsDetailBloc;
  NewsDetailScreenState(this._newsDetailBloc);

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() {
    widget._newsDetailBloc.add(UnNewsDetailEvent());
    widget._newsDetailBloc.add(LoadNewsDetailEvent(widget._id));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    return BlocBuilder<NewsDetailBloc, NewsDetailState>(
        bloc: widget._newsDetailBloc,
        builder: (
          BuildContext context,
          NewsDetailState currentState,
        ) {
          if (currentState is UnNewsDetailState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is InNewsDetailState) {
            return NewsDetailsItemBody(currentState: currentState);
          }
          if (currentState is ErrorNewsDetailState) {
            return Center();
          }
          return Center();
        });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
