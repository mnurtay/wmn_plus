import 'package:flutter/material.dart';
import 'package:wmn_plus/features/discounts/index.dart';

class DiscountsPage extends StatelessWidget {
  static const String routeName = "/discounts";

  @override
  Widget build(BuildContext context) {
    var _discountsBloc = DiscountsBloc();
    return Scaffold(
      appBar: appBar(),
      body: DiscountsScreen(discountsBloc: _discountsBloc),
    );
  }


   Widget appBar() {
    return AppBar(
        title: Text(
          "Скидки и акции", style: TextStyle(color: Colors.black)
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 4,
        actions: <Widget>[]);
  }
}
