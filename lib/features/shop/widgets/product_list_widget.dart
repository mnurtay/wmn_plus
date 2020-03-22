import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wmn_plus/features/shop/sub_category_products/sub_category_products_model.dart';
import 'package:wmn_plus/features/shop/widgets/product_item_widget.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    Key key,
    @required this.cat,
    @required this.sub,
    @required this.productList,
  }) : super(key: key);

  final int cat;
  final int sub;
  final ProductList productList;
  Widget build(BuildContext context) {
    double _crossAxisSpacing = 1, _mainAxisSpacing = 2, _aspectRatio = 0.55;
    int _crossAxisCount = 2;
    
    return GridView(
      physics:
          BouncingScrollPhysics(), // if you want IOS bouncing effect, otherwise remove this line
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _crossAxisCount,
        crossAxisSpacing: _crossAxisSpacing,
        mainAxisSpacing: _mainAxisSpacing,
        childAspectRatio: _aspectRatio,
      ), //change the number as you want
      children: productList.result.map((product) {
        return ProductsListItem(
          prodId: product.id,
          sub: this.sub,
          cat: this.cat,
          name: product.title,
          currentPrice: product.price,
          originalPrice: 555,
          discount: 555,
          imageUrl: product.image
        );
      }).toList(),
    );
  }

  
}
