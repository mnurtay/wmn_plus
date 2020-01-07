import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wmn_plus/features/news/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
class NewsPage extends StatefulWidget {
  List<String> category;
  NewsPage(this.category);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  NewsBloc _newsBloc;
  @override
  void initState() {
    _newsBloc = NewsBloc();
    super.initState();
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

    return Scaffold(
      appBar: appBar(),
      body: NewsScreen(
        newsBloc: _newsBloc,
        category: widget.category,
      ),
    );
  }

  Widget appBar() {
    if (Platform.isIOS)
    return AppBar(
        title: Text(AppLocalizations.of(context).tr('news'),
            style: Theme.of(context).textTheme.title),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        actions: <Widget>[]);
  }
}
