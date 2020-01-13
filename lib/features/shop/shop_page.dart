import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/index.dart';

class ShopPage extends StatelessWidget {
  static const String routeName = '/shop';

  @override
  Widget build(BuildContext context) {
    var _shopBloc = ShopBloc();
    return Scaffold(
      appBar: appBar(),
      body: ShopScreen(shopBloc: _shopBloc),
    );
  }

  
   Widget appBar() {
    return AppBar(
        title: Text(
          "Магазин", style: TextStyle(color: Colors.black)
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 4,
        actions: <Widget>[]);
  }
}
