import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/news/news_detail/index.dart';

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
    widget._newsDetailBloc.add(UnNewsDetailEvent());
    widget._newsDetailBloc.add(LoadNewsDetailEvent(widget._id));
    super.initState();
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
            return Scaffold(
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: ScreenUtil.getInstance().setHeight(500),
                      floating: true,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          background: Image.network(
                            currentState.newsDetail.result.image,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            currentState.newsDetail.result.title,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(55),
                              fontWeight: FontWeight.w500,
                              color: Color(0xffD748DA),
                            ),
                          ),
                          Html(data: currentState.newsDetail.result.content),
                        ],
                      )),
                ),
              ),
            );
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
