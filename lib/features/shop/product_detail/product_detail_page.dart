import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/product_detail/index.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage(this.id);

  static const String routeName = '/productDetail';
  final int id;
  @override
  Widget build(BuildContext context) {
    var _productDetailBloc = ProductDetailBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text('ProductDetail'),
      ),
      body: ProductDetailScreen(productDetailBloc: _productDetailBloc),
    );
  }
}
