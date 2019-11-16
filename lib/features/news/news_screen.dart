import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/news/index.dart';
import 'package:wmn_plus/locale/app_localization.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({
    Key key,
    @required NewsBloc newsBloc,
  })  : _newsBloc = newsBloc,
        super(key: key);

  final NewsBloc _newsBloc;

  @override
  NewsScreenState createState() {
    return NewsScreenState(_newsBloc);
  }
}

class NewsScreenState extends State<NewsScreen> {
  final NewsBloc _newsBloc;
  NewsScreenState(this._newsBloc);
  List<String> _category = ['A', 'B', 'C', 'D']; // Option 2
  String _selectedCategory;
  int _categoryPosition = 0;

  @override
  void initState() {
    super.initState();
    // widget._newsBloc.add(UnNewsEvent());
    widget._newsBloc.add(LoadNewsEvent(category: _categoryPosition));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);

    return SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(ScreenUtil.getInstance().setHeight(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.all(ScreenUtil.getInstance().setHeight(20)),
                    child: Text(
                      AppLocalization.of(context).novosty,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(50)),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  DropdownButton(
                    hint: Text(
                        'Выбрать категорию новостей'), // Not necessary for Option 1
                    value: _selectedCategory,
                    onChanged: (newValue) {
                      setState(() {
                        for (int i = 0; i < _category.length; i++) {
                          if (newValue == _category[i]) {
                            _categoryPosition = i;
                            widget._newsBloc.add(LoadNewsEvent(category: i));
                          }
                        }
                        _selectedCategory = newValue;
                      });
                    },
                    items: _category.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(25),
              ),
              new BlocBuilder<NewsBloc, NewsState>(
                  bloc: widget._newsBloc,
                  builder: (
                    BuildContext context,
                    NewsState currentState,
                  ) {
                    if (currentState is UnNewsState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (currentState is ErrorNewsState) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(currentState.errorMessage ?? 'Error'),
                        ],
                      ));
                    }
                    if (currentState is InNewsState) {
                      print("InNewsState + ${currentState.newsList}");
                      // if (currentState.newsList == null){
                      //   return Container();
                      // }
                      return Expanded(
                        child: new ListView.builder(
                          padding: EdgeInsets.all(
                              ScreenUtil.getInstance().setHeight(30)),
                          itemCount: currentState.newsList.length,
                          itemBuilder: (context, index) {
                            return buildNewsItem(
                                context, currentState.newsList[index]);
                          },
                        ),
                      );
                      // return new Expanded(
                      //   child: new PagewiseListView(
                      //       pageSize: 10,
                      //       padding: EdgeInsets.all(
                      //           ScreenUtil.getInstance().setHeight(30)),
                      //       itemBuilder: (context, entry, index) {
                      //         return buildNewsItem(context, entry);
                      //       },
                      //       pageFuture: (pageIndex) {
                      //         //Direct to repository
                      //         var newsList = new NewsRepository().getNewsList(
                      //             pageIndex, currentState.category);
                      //         return newsList;
                      //       }),
                      // );
                    }
                    if (currentState is CategoryOneNewsState) {
                      // return new Expanded(
                      //   child: new PagewiseListView(
                      //       pageSize: 9,
                      //       padding: EdgeInsets.all(
                      //           ScreenUtil.getInstance().setHeight(30)),
                      //       itemBuilder: (context, entry, index) {
                      //         return buildNewsItem(context, entry);
                      //       },
                      //       pageFuture: (pageIndex) {
                      //         //Direct to repository
                      //         var newsList = new NewsRepository().getNewsList(
                      //             pageIndex, 1);
                      //         return newsList;
                      //       }),
                      // );
                      // return Container(height: 50, color: Colors.black);
                    }
                    return Center(child: Text("Development"));
                  })
            ],
          )),
    );
  }

  Widget buildNewsItem(BuildContext context, NewsModel data) {
    return Container(
        margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(25)),
        height: ScreenUtil.getInstance().setHeight(500),
        width: MediaQuery.of(context).size.width,
        child: Container(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil.getInstance().setHeight(50)),
            child: Text(data.name,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(50),
                    color: Colors.white)),
          ),
          decoration: BoxDecoration(
              color: Colors.black38, borderRadius: BorderRadius.circular(16)),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://avatars.mds.yandex.net/get-zen_doc/42056/pub_5bc6ea133887bf00ac5276f4_5bc6ed07f4355200abcac179/scale_1200"))));
  }

  // void _load([bool isError = false]) {

  //   widget._newsBloc.add(LoadNewsEvent(isError));
  // }
}
