import 'package:flutter/material.dart';
import 'package:wmn_plus/features/news/index.dart';
import 'package:wmn_plus/locale/app_localization.dart';

class NewsPage extends StatelessWidget {
  static const String routeName = "/news";

  @override
  Widget build(BuildContext context) {
    
    var _newsBloc = NewsBloc();

    return Scaffold(
      body: NewsScreen(newsBloc: _newsBloc),
    );
  }
}
