import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/database/database.dart';
import 'package:wmn_plus/features/shop/index.dart';

class ShopPage extends StatelessWidget {
  static const String routeName = '/shop';
  var db = DatabaseHelper.instance;
  int itemCount = 0;
  Future<dynamic> getCount() async {
    return await db.queryRowCount();
  }
  
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
        title: Text("Магазин", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 4,
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(),
              width: 50,
              height: 50,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      bottom: 10,
                      left: 0,
                      child: Icon(Icons.shopping_cart, color: Colors.black)),
                  FutureBuilder<dynamic>(
                      future: getCount(),
                      initialData: "0",
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return Positioned(
                            bottom: 28,
                            right: 20,
                            child: Text(snapshot.data.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold)),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ],
              ),
            ),
          )
        ]);
  }
}
