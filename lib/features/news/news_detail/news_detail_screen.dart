import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/news/news_detail/index.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({
    Key key,
    @required NewsDetailBloc newsDetailBloc,
  })  : _newsDetailBloc = newsDetailBloc,
        super(key: key);

  final NewsDetailBloc _newsDetailBloc;

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
    // this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Collapsing Toolbar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    )),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(icon: Icon(Icons.info), text: "Tab 1"),
                      Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: Center(
            child: Text("Sample text"),
          ),
        ),
      ),
    );
  }
    // return BlocBuilder<NewsDetailBloc, NewsDetailState>(
    //     bloc: widget._newsDetailBloc,
    //     builder: (
    //       BuildContext context,
    //       NewsDetailState currentState,
    //     ) {
    //       if (currentState is UnNewsDetailState) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (currentState is ErrorNewsDetailState) {
    //         return Center(
    //             child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             Text(currentState.errorMessage ?? 'Error'),
    //             Padding(
    //               padding: const EdgeInsets.only(top: 32.0),
    //               child: RaisedButton(
    //                 color: Colors.blue,
    //                 child: Text("reload"),
    //                 onPressed: () => this._load(),
    //               ),
    //             ),
    //           ],
    //         ));
    //       }
    //       return Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             Text("Flutter files: done"),
    //             Padding(
    //               padding: const EdgeInsets.only(top: 32.0),
    //               child: RaisedButton(
    //                 color: Colors.red,
    //                 child: Text("throw error"),
    //                 onPressed: () => this._load(true),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     });
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