import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wmn_plus/features/news/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);

    var _newsBloc = NewsBloc();

    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).tr('news'),
              style: Theme.of(context).textTheme.title),
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          actions: <Widget>[]),
      body: NewsScreen(newsBloc: _newsBloc),
    );
  }
}
