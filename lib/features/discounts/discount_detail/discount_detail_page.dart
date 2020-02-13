import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wmn_plus/features/discounts/discount_detail/index.dart';

class DiscountDetailPage extends StatelessWidget {
  static const String routeName = "/discountDetail";
  final Map<String, dynamic> route;
  DiscountDetailPage(this.route);

  static String assetName = 'assets/qr.svg';
  final Widget svgIcon = SvgPicture.asset(
    assetName,
    color: Colors.white,
    semanticsLabel: 'qr',
    width: 32,
    height: 32,
  );

  @override
  Widget build(BuildContext context) {
    var _discountDetailBloc = DiscountDetailBloc();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: DiscountDetailScreen(
          discountDetailBloc: _discountDetailBloc, route: route),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDialog(context);
          },
          elevation: 10.0,
          child: svgIcon),

    );
  }

  void _showDialog(BuildContext context) {
    print("WMN Plus - ${route["discountName"]} ",);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Ваш QR Code"),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: QrImage(
                    data: "WMN Plus - ${route["discountName"]} ",
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Закрыть"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
