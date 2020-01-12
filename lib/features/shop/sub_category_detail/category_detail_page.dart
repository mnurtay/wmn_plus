import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/sub_category_detail/index.dart';

class CategoryDetailPage extends StatelessWidget {
  static const String routeName = '/categoryDetail';
  final int i = 0;
  final Map<String, dynamic> route;
  CategoryDetailPage(this.route);
  @override
  Widget build(BuildContext context) {

    var _categoryDetailBloc = CategoryDetailBloc();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          route["title"],
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: CategoryDetailScreen(
        categoryDetailBloc: _categoryDetailBloc,
        id: route["id"],
      ),
    );
  }
}
