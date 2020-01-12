import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/index.dart';

class ShopPage extends StatelessWidget {
  static const String routeName = '/shop';

  @override
  Widget build(BuildContext context) {
    var _shopBloc = ShopBloc();
    return Scaffold(
      appBar: appBar(context),
      body: ShopScreen(shopBloc: _shopBloc),
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
        title: Text(
          "Магазин"
        ),
        backgroundColor: Colors.blue,
        centerTitle: false,
        elevation: 4,
        actions: <Widget>[]);
  }
}
