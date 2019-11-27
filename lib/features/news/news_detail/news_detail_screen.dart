import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return NewsDetailScreenState(_newsDetailBloc);
  }
}

class NewsDetailScreenState extends State<NewsDetailScreen> {
  final NewsDetailBloc _newsDetailBloc;
  NewsDetailScreenState(this._newsDetailBloc);

  @override
  void initState() {
    super.initState();
    widget._newsDetailBloc.add(LoadNewsDetailEvent(widget._id));
    print("news id " + widget._id);
    // this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: DefaultTabController(
    //     length: 2,
    //     child: NestedScrollView(
    //       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //         return <Widget>[
    //           SliverAppBar(
    //             expandedHeight: 200.0,
    //             floating: false,
    //             pinned: true,
    //             flexibleSpace: FlexibleSpaceBar(
    //                 centerTitle: true,
    //                 title: Text("Как стать беременной?",
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 16.0,
    //                     )),
    //                 background: Image.network(
    //                   "https://medaboutme.ru/upload/iblock/c28/shutterstock_526489315.jpg",
    //                   fit: BoxFit.cover,
    //                 )),
    //           ),
    //           SliverPersistentHeader(
    //             delegate: _SliverAppBarDelegate(
    //               TabBar(
    //                 labelColor: Colors.black87,
    //                 unselectedLabelColor: Colors.grey,
    //                 tabs: [
    //                   Tab(icon: Icon(Icons.info), text: "Tab 1"),
    //                   Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
    //                 ],
    //               ),
    //             ),
    //             pinned: true,
    //           ),
    //         ];
    //       },
    //       body: Center(
    //         child: Text(
    //             "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum,  comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from  by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham"),
    //       ),
    //     ),
    //   ),
    // );

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
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(currentState.newsDetail.result.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              )),
                          background: Image.network(
                            currentState.newsDetail.result.imageUrl,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ];
                },
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(currentState.newsDetail.result.content)
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
// void _load([bool isError = false]) {
//   widget._newsDetailBloc.add(UnNewsDetailEvent());
//   widget._newsDetailBloc.add(LoadNewsDetailEvent(isError));
// }

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
