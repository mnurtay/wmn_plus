import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/buy_product/index.dart';

class BuyProductPage extends StatelessWidget {
  static const String routeName = '/buyProduct';
  final Map<String, dynamic> routes = {
    "routes": {"cat": 1, "id": 1, "sub": 1}
  };

  @override
  Widget build(BuildContext context) {
    var _buyProductBloc = BuyProductBloc();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Оформление заказа',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BuyProductScreen(buyProductBloc: _buyProductBloc),
    );
  }
}
