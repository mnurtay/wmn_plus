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
    print("sub $sub || cat $cat ");

    Size screenSize = MediaQuery.of(context).size;
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
          currentPrice: 524,
          originalPrice: 699,
          discount: 25,
          imageUrl:
              "https://n1.sdlcdn.com/imgs/c/9/8/Lambency-Brown-Solid-Casual-Blazers-SDL781227769-1-1b660.jpg",
        );
      }).toList(),
    );
  }

  _dummyProductsList() {
    return [
      ProductsListItem(
        name: "Michael Kora",
        currentPrice: 524,
        originalPrice: 699,
        discount: 25,
        imageUrl:
            "https://n1.sdlcdn.com/imgs/c/9/8/Lambency-Brown-Solid-Casual-Blazers-SDL781227769-1-1b660.jpg",
      ),
      ProductsListItem(
        name: "Michael Kora",
        currentPrice: 524,
        originalPrice: 699,
        discount: 25,
        imageUrl:
            "https://n1.sdlcdn.com/imgs/c/9/8/Lambency-Brown-Solid-Casual-Blazers-SDL781227769-1-1b660.jpg",
      ),
      ProductsListItem(
        name: "David Klin",
        currentPrice: 249,
        originalPrice: 499,
        discount: 50,
        imageUrl:
            "https://images-na.ssl-images-amazon.com/images/I/71O0zS0DT0L._UX342_.jpg",
      ),
      ProductsListItem(
        name: "Nakkana",
        currentPrice: 899,
        originalPrice: 1299,
        discount: 23,
        imageUrl:
            "https://assets.myntassets.com/h_240,q_90,w_180/v1/assets/images/1304671/2016/4/14/11460624898615-Hancock-Men-Shirts-8481460624898035-1_mini.jpg",
      ),
      ProductsListItem(
        name: "David Klin",
        currentPrice: 249,
        originalPrice: 499,
        discount: 20,
        imageUrl:
            "https://images-na.ssl-images-amazon.com/images/I/71O0zS0DT0L._UX342_.jpg",
      ),
      ProductsListItem(
        name: "Nakkana",
        currentPrice: 899,
        originalPrice: 1299,
        discount: 23,
        imageUrl:
            "https://assets.myntassets.com/h_240,q_90,w_180/v1/assets/images/1304671/2016/4/14/11460624898615-Hancock-Men-Shirts-8481460624898035-1_mini.jpg",
      ),
    ];
  }
}
