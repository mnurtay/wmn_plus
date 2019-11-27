import 'package:flutter/material.dart';
import 'package:wmn_plus/features/news/news_detail/index.dart';

class NewsDetailPage extends StatelessWidget {
  static const String routeName = "/newsDetail";
  final String id;
  NewsDetailPage(this.id);
  @override
  Widget build(BuildContext context) {
    var _newsDetailBloc = NewsDetailBloc();
    return Scaffold(
      body: NewsDetailScreen(newsDetailBloc: _newsDetailBloc, id: id),
    );
  }
}
