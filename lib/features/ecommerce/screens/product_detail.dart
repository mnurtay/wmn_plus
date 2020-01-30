import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:wmn_plus/features/ecommerce/models/option_type.dart';
import 'package:wmn_plus/features/ecommerce/models/option_value.dart';
import 'package:wmn_plus/features/ecommerce/models/product.dart';
import 'package:wmn_plus/features/ecommerce/models/review.dart';
import 'package:wmn_plus/features/ecommerce/scoped-models/main.dart';
import 'package:wmn_plus/features/ecommerce/screens/auth.dart';
import 'package:wmn_plus/features/ecommerce/screens/search.dart';
import 'package:wmn_plus/features/ecommerce/utils/connectivity_state.dart';
import 'package:wmn_plus/features/ecommerce/utils/constants.dart';
import 'package:wmn_plus/features/ecommerce/utils/constants.dart' as prefix0;
import 'package:wmn_plus/features/ecommerce/utils/headers.dart';
import 'package:wmn_plus/features/ecommerce/utils/locator.dart';
import 'package:wmn_plus/features/ecommerce/widgets/rating_bar.dart';
import 'package:wmn_plus/features/ecommerce/widgets/shopping_cart_button.dart';
import 'package:wmn_plus/features/ecommerce/widgets/snackbar.dart';
import 'package:wmn_plus/features/ecommerce/screens/cart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  ProductDetailScreen(this.product);
  @override
  State<StatefulWidget> createState() {
    return _ProductDetailScreenState();
  }
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  TabController _tabController;
  Size _deviceSize;
  int quantity = 1;
  Product selectedProduct;

  String htmlDescription;
  List<Product> similarProducts = List();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String pincode = '';

  @override
  void initState() {
    selectedProduct = widget.product;

    htmlDescription =
        widget.product.description != null ? widget.product.description : '';

    locator<ConnectivityManager>().initConnectivity(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    locator<ConnectivityManager>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('Детали товара'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) => ProductSearch());
                  Navigator.of(context).push(route);
                },
              ),
              shoppingCartIconButton()
            ],
          ),
          body: highlightsTab(),
          floatingActionButton: addToCartFAB());
    });
  }

  Widget quantityRow(MainModel model, Product selectedProduct) {
    return Container(
        height: 60.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Container();
            } else {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    quantity = index;
                  });
                },
                child: Container(
                    width: 45,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: quantity == index
                              ? Colors.green
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.center,
                    // margin: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      index.toString(),
                      style: TextStyle(
                          color: quantity == index
                              ? Colors.green
                              : Colors.grey.shade300),
                    )),
              );
            }
          },
        ));
  }

  Widget highlightsTab() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Expanded(
                        //   child:
                        Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: 300,
                            width: 220,
                            child: FadeInImage(
                              image: NetworkImage(selectedProduct.image != null
                                  ? selectedProduct.image
                                  : ''),
                              placeholder: AssetImage(
                                  'images/placeholders/no-product-image.png'),
                            ),
                          ),
                        )

                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: _deviceSize.width,
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          '${selectedProduct.title}',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontFamily: fontFamily),
                        ),
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     ratingBar(selectedProduct.avgRating, 20),
                      //     Container(
                      //         margin: EdgeInsets.only(right: 10),
                      //         child: Text(selectedProduct.reviewsCount)),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: Text(
                  selectedProduct.title,
                  style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w300,
                      fontFamily: fontFamily),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              true
                  ? Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Количество',
                        style: TextStyle(fontSize: 14, fontFamily: fontFamily),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 5,
              ),
              true ? quantityRow(model, selectedProduct) : Container(),
              Divider(),
              buildPriceRow('Цена ', selectedProduct.price + " KZT",
                  strike: false,
                  originalPrice:
                      '${selectedProduct.currencySymbol} ${selectedProduct.price}'),
              Divider(
                height: 1.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              addToCartFlatButton(),
              SizedBox(
                height: 12.0,
              ),
              !true ? Container() : buyNowFlatButton(),
              Divider(),
              SizedBox(
                height: 2,
              ),
              HtmlWidget(htmlDescription),
            ],
          ),
        ),
      );
    });
  }

  Widget buyNowFlatButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: double.infinity,
            height: 45.0,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: true ? Colors.deepOrange : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                true ? 'Купить сейчас' : 'OUT OF STOCK',
                style: TextStyle(color: true ? Colors.deepOrange : Colors.grey),
              ),
              onPressed: true
                  ? () {
                      Scaffold.of(context).showSnackBar(processSnackbar);
                      if (true) {
                        model.addProduct(product: selectedProduct);
                        print(selectedProduct.id + quantity);
                        if (!model.isLoading) {
                          Scaffold.of(context).showSnackBar(completeSnackbar);
                          MaterialPageRoute route =
                              MaterialPageRoute(builder: (context) => Cart());

                          Navigator.push(context, route);
                        }
                      }
                    }
                  : () {},
            ),
          ),
        );
      },
    );
  }

  Widget addToCartFlatButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: double.infinity,
            height: 45.0,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: true ? Colors.green : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Добавить в корзину',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: true
                  ? () {
                      Scaffold.of(context).showSnackBar(processSnackbar);
                      if (true) {
                        model.addProduct(
                            product: selectedProduct, quantity: quantity);
                        print("PRODUCT + ${selectedProduct.title} " +
                            "quantity $quantity");

                        if (!model.isLoading) {
                          Scaffold.of(context).showSnackBar(completeSnackbar);
                        }
                      }
                    }
                  : () {},
            ),
          ),
        );
      },
    );
  }

  Widget addToCartFAB() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
       return FloatingActionButton(
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: true
                    ? () {
                        Scaffold.of(context).showSnackBar(processSnackbar);
                        true
                            ? model.addProduct(
                                product: selectedProduct, quantity: quantity)
                            : null;
                        print(selectedProduct.id + quantity);

                        if (!model.isLoading) {
                          Scaffold.of(context).showSnackBar(completeSnackbar);
                        }
                      }
                    : () {},
                backgroundColor: true ? Colors.deepOrange : Colors.grey,
              );
      },
    );
  }

  Widget buildPriceRow(String key, String value,
      {bool strike, String originalPrice, String discountPercent}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(10),
          child: Text(
            key,
            style: TextStyle(
              fontSize: 17,
              fontFamily: fontFamily,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(10),
          child: RichText(
            text: TextSpan(children: [
              
              TextSpan(text: '   '),
              TextSpan(
                  text: value,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold)),
            ]),
          ),
        ),
      ],
    );
  }
}
