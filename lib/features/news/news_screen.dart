import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/news/index.dart';
import 'package:wmn_plus/features/news/widgets/news_item.dart';
import 'package:wmn_plus/features/news/widgets/news_list.dart';
import 'package:wmn_plus/locale/app_localization.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({
    Key key,
    @required List<String> category,
    @required NewsBloc newsBloc,
  })  : _category = category,
        _newsBloc = newsBloc,
        super(key: key);

  final List<String> _category;
  final NewsBloc _newsBloc;

  @override
  NewsScreenState createState() {
    return NewsScreenState(_newsBloc);
  }
}

class NewsScreenState extends State<NewsScreen> {
  final NewsBloc _newsBloc;
  NewsScreenState(this._newsBloc);

  String _selectedCategory;
  int _categoryPosition = 0;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() {
    widget._newsBloc.add(UnNewsEvent());
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

    return buildBody();
  }

  Column buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(ScreenUtil.getInstance().setHeight(30)),
          child: DropdownButton(
            hint: Text('Выбрать категорию новостей'),
            value: _selectedCategory,
            onChanged: (newValue) {
              setState(() {
                for (int i = 0; i < widget._category.length; i++) {
                  if (newValue == widget._category[i]) {
                    _categoryPosition = i;
                    _newsBloc.add(LoadNewsEvent(category: i));
                  }
                }
                _selectedCategory = newValue;
              });
            },
            items: widget._category.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
          ),
        ),
        BlocBuilder<NewsBloc, NewsState>(
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
                return NewsList(currentState: currentState);
              }
              return Center(child: Text("Development"));
            })
      ],
    );
  }
}
