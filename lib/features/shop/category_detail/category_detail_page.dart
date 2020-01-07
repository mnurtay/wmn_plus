import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/category_detail/index.dart';

class CategoryDetailPage extends StatelessWidget {
  static const String routeName = '/categoryDetail';
  final int i;
  CategoryDetailPage(this.i);
  @override
  Widget build(BuildContext context) {
    var _categoryDetailBloc = CategoryDetailBloc();
    return Scaffold(
      appBar: AppBar(),
      body: CategoryDetailScreen(categoryDetailBloc: _categoryDetailBloc),
    );
  }
}
