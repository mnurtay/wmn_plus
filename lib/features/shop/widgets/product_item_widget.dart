import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/database/database.dart';
import 'package:wmn_plus/features/shop/product_detail/product_detail_page.dart';

import 'package:wmn_plus/features/shop/sub_category_products/sub_category_products_page.dart';

class ProductsListItem extends StatefulWidget {
  final String name;
  final int currentPrice;
  final int originalPrice;
  final int discount;
  final String imageUrl;
  final int cat;
  final int sub;
  final int prodId;
  final dbHelper = DatabaseHelper.instance;

  ProductsListItem(
      {Key key,
      this.name,
      this.currentPrice,
      this.originalPrice,
      this.discount,
      this.cat,
      this.prodId,
      this.sub,
      this.imageUrl})
      : super(key: key);

  @override
  _ProductsListItemState createState() => _ProductsListItemState();
}

class _ProductsListItemState extends State<ProductsListItem> {
  bool added = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildProductItemCard(context),
      ],
    );
  }

  _buildProductItemCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Map<String, int> keyRoute = new Map();
        keyRoute["cat"] = widget.cat;
        keyRoute["sub"] = widget.sub;
        keyRoute["id"] = widget.prodId;

        Navigator.pushNamed(context, ProductDetailPage.routeName,
            arguments: keyRoute);
      },
      child: Card(
        elevation: 4.0,
        child: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Image.network(
                    widget.imageUrl,
                  ),
                  height: 200.0,
                  width: MediaQuery.of(context).size.width / 2.5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                    Text(
                      "${widget.currentPrice} KZT",
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    raisedButton(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget raisedButton(BuildContext context) {
    if (!added)
      return RaisedButton(
        onPressed: () {
          _insert();
        },
        child: Container(
          padding: EdgeInsets.all(4),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              "Добавить в корзину",
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          ),
        ),
      );
    else
      return Container(
        padding: EdgeInsets.all(4),
        color: Colors.greenAccent,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            "Добавлено",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
        ),
      );
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: widget.name,
      DatabaseHelper.columnPrice: widget.currentPrice,
      DatabaseHelper.columnProdId: widget.prodId
    };
    print(row.toString());
    final id = await widget.dbHelper.insert(row);

    setState(() {
      print("$id inserted");
      added = !added;
    });
  }
}
