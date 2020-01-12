import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/product_detail/index.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage(this.routes);

  static const String routeName = '/productDetail';
  final Map<String, int> routes;
  @override
  Widget build(BuildContext context) {
    var _productDetailBloc = ProductDetailBloc();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ProductDetailScreen(
        productDetailBloc: _productDetailBloc,
        map: routes,
      ),
    );
  }
}
