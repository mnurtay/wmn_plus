import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/shop_model.dart';
import 'package:wmn_plus/features/shop/sub_category_products/sub_category_products_page.dart';

class CatergoryItem extends StatelessWidget {
  const CatergoryItem({
    Key key,
    this.id,
    @required this.subcategories,
  }) : super(key: key);

  final Subcategories subcategories;
  final int id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Map<String, dynamic> keyRoute = new Map();
        keyRoute["cat"] = id;
        keyRoute["sub"] = subcategories.id;
        keyRoute["title"] = subcategories.title;
        Navigator.pushNamed(context, SubCategoryProductsPage.routeName,
            arguments: keyRoute);
      },
      child: Card(
        child: Container(
          width: 130,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: cardBackgroundImage(subcategories),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(subcategories.title,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardBackgroundImage(Subcategories subcategories) {
    if (subcategories.products.length > 0)
      return Image.network(subcategories.products[0].image);
    else
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
        ),
      );
  }
}
