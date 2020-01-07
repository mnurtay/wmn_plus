import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/index.dart';

class ShopPage extends StatelessWidget {
  static const String routeName = '/shop';

  @override
  Widget build(BuildContext context) {
    var _shopBloc = ShopBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text("Магазин", style: Theme.of(context).textTheme.title),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
      ),
      body: ShopScreen(shopBloc: _shopBloc),
    );
  }
}
