import 'package:flutter/material.dart';
import 'package:wmn_plus/features/discounts/index.dart';

class DiscountsPage extends StatelessWidget {
  static const String routeName = "/discounts";

  @override
  Widget build(BuildContext context) {
    var _discountsBloc = DiscountsBloc();
    return Scaffold(
      appBar: AppBar(
          title: Text('Скидки и акции', style: Theme.of(context).textTheme.title),
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          ),
      body: DiscountsScreen(discountsBloc: _discountsBloc),
    );
  }
}
