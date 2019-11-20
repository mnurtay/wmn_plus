import 'package:flutter/material.dart';
import 'package:wmn_plus/features/news/index.dart';
import 'package:wmn_plus/locale/app_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsPage extends StatelessWidget {
  static const String routeName = "/news";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    List<String> _category = ['A', 'B', 'C', 'D']; // Option 2
    String _selectedCategory;
    int _categoryPosition = 0;
    var _newsBloc = NewsBloc();

    return Scaffold(
      appBar: AppBar(
          title: Text('Новости', style: Theme.of(context).textTheme.title),
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          actions: <Widget>[
            DropdownButton(
              hint: Text(
                  'Выбрать категорию новостей'), 
              value: _selectedCategory,
              onChanged: (newValue) {
                for (int i = 0; i < _category.length; i++) {
                  if (newValue == _category[i]) {
                    _categoryPosition = i;
                    _newsBloc.add(LoadNewsEvent(category: i));
                  }
                }
                _selectedCategory = newValue;
              },
              items: _category.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            )
          ]),
      body: NewsScreen(newsBloc: _newsBloc),
    );
  }

  Widget appBar(BuildContext context) {}
}
