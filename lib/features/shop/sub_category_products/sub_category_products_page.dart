import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/sub_category_products/index.dart';

class SubCategoryProductsPage extends StatelessWidget {
  static const String routeName = '/subCategoryProducts';
  Map<String, dynamic> pages;
  SubCategoryProductsPage(this.pages);
  @override
  Widget build(BuildContext context) {
    var _subCategoryProductsBloc = SubCategoryProductsBloc();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(pages["title"], style: TextStyle(color: Colors.black),),
      ),
      body: SubCategoryProductsScreen(
          subCategoryProductsBloc: _subCategoryProductsBloc, map: pages),
    );
  }
}
