import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/shop/sub_category_detail/category_detail_model.dart';
import 'package:wmn_plus/features/shop/sub_category_products/sub_category_products_page.dart';
import 'package:wmn_plus/features/shop/widgets/product_item_widget.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key key,
    @required this.sub,
    @required this.products,
    @required this.id,
  }) : super(key: key);
  final int id;
  final int sub;
  final List<Products> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: products.length,
          itemBuilder: (context, indexSub) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(products[indexSub].title,
                    style: Theme.of(context).textTheme.title),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: () {
                    Map<String, dynamic> keyRoute = new Map();
                    keyRoute["cat"] = id;
                    keyRoute["sub"] = products[indexSub].id;
                    keyRoute["title"] = products[indexSub].title;
                    Navigator.pushNamed(
                        context, SubCategoryProductsPage.routeName,
                        arguments: keyRoute);
                  },
                  child: Text(
                    "Посмотреть",
                    style: TextStyle(color: Color(0xff0CB19A4)),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xff0CB19A4))),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(10),
                ),
                Container(
                  height: 350,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: this.products.length,
                      itemBuilder: (context, index) {
                        return ProductsListItem(
                          cat: id,
                          sub: sub,
                          prodId: products[index].id,
                          currentPrice: this.products[index].price,
                          name: this.products[index].title,
                          imageUrl:
                              "https://www.canali.com/media/catalog/product/cache/image/9df78eab33525d08d6e5fb8d27136e95/9/1/91700-PD00018-301_c_SCHEDA.jpg",
                        );
                      }),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(20),
                ),
              ],
            );
          }),
    );
  }
}
