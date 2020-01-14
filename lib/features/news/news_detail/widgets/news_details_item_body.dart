import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/news/news_detail/news_detail_state.dart';

class NewsDetailsItemBody extends StatelessWidget {
  const NewsDetailsItemBody({
    Key key,
    @required this.currentState,
  }) : super(key: key);

  final InNewsDetailState currentState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Html(data: currentState.newsDetail.result.content),
                ],
              )),
        ),
      ),
    );
  }
}
