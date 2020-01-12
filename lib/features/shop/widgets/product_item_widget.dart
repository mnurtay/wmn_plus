import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/product_detail/product_detail_page.dart';

import 'package:wmn_plus/features/shop/sub_category_products/sub_category_products_page.dart';

class ProductsListItem extends StatelessWidget {
  final String name;
  final int currentPrice;
  final int originalPrice;
  final int discount;
  final String imageUrl;
  final int cat;
  final int sub;
  final int prodId;

  const ProductsListItem(
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
        keyRoute["cat"] = this.cat;
        keyRoute["sub"] = this.sub;
        keyRoute["id"] = this.prodId;
        print("PIW $cat $sub $prodId");

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
                    imageUrl,
                  ),
                  height: 250.0,
                  width: MediaQuery.of(context).size.width / 2.5,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "$currentPrice KZT",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
