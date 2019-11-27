import 'package:flutter/material.dart';
import 'package:wmn_plus/features/discounts/discount_detail/index.dart';

class DiscountDetailPage extends StatelessWidget {
  static const String routeName = "/discountDetail";

  @override
  Widget build(BuildContext context) {
    var _discountDetailBloc = DiscountDetailBloc();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: DiscountDetailScreen(discountDetailBloc: _discountDetailBloc),
    );
  }
}
