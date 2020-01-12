import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/buy_product/index.dart';

class BuyProductPage extends StatelessWidget {
  BuyProductPage(this.routes);
  static const String routeName = '/buyProduct';
  final Map<String, int> routes;

  @override
  Widget build(BuildContext context) {
    var _buyProductBloc = BuyProductBloc();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Оформление заказа',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BuyProductScreen(buyProductBloc: _buyProductBloc, routes: routes),
    );
  }
}
