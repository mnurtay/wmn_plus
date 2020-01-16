import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wmn_plus/features/shop/buy_product/buy_product_page.dart';
import 'package:wmn_plus/features/shop/product_detail/index.dart';
import 'package:wmn_plus/features/shop/sub_category_detail/category_detail_state.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    Key key,
    @required Map<String, int> map,
    @required ProductDetailBloc productDetailBloc,
  })  : _productDetailBloc = productDetailBloc,
        _routes = map,
        super(key: key);

  final ProductDetailBloc _productDetailBloc;
  final Map<String, int> _routes;

  @override
  ProductDetailScreenState createState() {
    return ProductDetailScreenState(_productDetailBloc);
  }
}

class ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
  final ProductDetailBloc _productDetailBloc;
  ProductDetailScreenState(this._productDetailBloc);
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    print(jsonEncode(widget._routes));
    this._load(
      widget._routes["cat"],
      widget._routes["sub"],
      widget._routes["id"],
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        bloc: widget._productDetailBloc,
        builder: (
          BuildContext context,
          ProductDetailState currentState,
        ) {
          if (currentState is UnProductDetailState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorProductDetailState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: () => this._load(1, 1, 1),
                  ),
                ),
              ],
            ));
          }
          if (currentState is InProductDetailState)
            return Scaffold(
              body:
                  _buildProductDetailsPage(context, currentState.hello.result),
              bottomNavigationBar:
                  _buildBottomNavigationBar(currentState.hello.result),
            );
        });
  }

  _buildProductDetailsPage(BuildContext context, Result result) {
    Size screenSize = MediaQuery.of(context).size;

    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildProductImagesWidgets(result.images),
                _buildProductTitleWidget(result.title),
                SizedBox(height: 12.0),
                _buildPriceWidgets(result.price),
                SizedBox(height: 12.0),
                _buildDivider(screenSize),
                SizedBox(height: 12.0),
                _buildDetailsAndMaterialWidgets(
                    result.description, result.characteristics),
                SizedBox(height: 12.0),
                _buildDivider(screenSize),
                SizedBox(height: 12.0),
                _buildStyleNoteHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildStyleNoteData(result.properties),
                SizedBox(height: 20.0),
                _buildMoreInfoHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildMoreInfoData(result.additional),
                SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildDivider(Size screenSize) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[600],
          width: screenSize.width,
          height: 0.25,
        ),
      ],
    );
  }

  _buildProductImagesWidgets(List<String> images) {
    TabController imagesController = TabController(length: 1, vsync: this);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 250.0,
        child: Center(
          child: DefaultTabController(
            length: 1,
            child: Stack(
              children: <Widget>[
                TabBarView(
                  controller: imagesController,
                  children: <Widget>[
                    Image.network(images[0]),
                  ],
                ),
                Container(
                  alignment: FractionalOffset(0.5, 0.95),
                  child: TabPageSelector(
                    controller: imagesController,
                    selectedColor: Colors.grey,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildProductTitleWidget(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: Text(
          //name,
          title,
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      ),
    );
  }

  _buildPriceWidgets(int price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "$price KZT",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
          SizedBox(
            width: 8.0,
          ),
        ],
      ),
    );
  }

  _buildDetailsAndMaterialWidgets(String opc, String char) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            controller: tabController,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Описание",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Характеристики",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          _buildDivider(MediaQuery.of(context).size),
          Container(
            height: 200.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  Html(
                    data: opc,
                  ),
                  Html(
                    data: char,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildStyleNoteHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Особенности",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildStyleNoteData(String prop) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
        ),
        child: Html(
          data: prop,
        ));
  }

  _buildMoreInfoHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Дополнительно",
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
    );
  }

  _buildMoreInfoData(String additional) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
        ),
        child: Html(data: additional));
  }

  _buildBottomNavigationBar(Result result) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      child: RaisedButton(
        onPressed: () {
          Map<String, dynamic> map = Map();
          map["routes"] = widget._routes;
          map["product"] = jsonEncode(result);
          Navigator.pushNamed(context, BuyProductPage.routeName,
              arguments: map);
        },
        color: Color(0xff0CB19A4),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                "Купить",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _load(int cat, int sub, int id) {
    widget._productDetailBloc.add(UnProductDetailEvent());
    widget._productDetailBloc.add(LoadProductDetailEvent(cat, sub, id));
  }
}
