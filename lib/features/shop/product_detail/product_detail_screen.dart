import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    this._load(
      widget._routes["cat"],
      widget._routes["sub"],
      widget._routes["id"],
    );
  }

  @override
  void dispose() {
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
              bottomNavigationBar: _buildBottomNavigationBar(currentState.hello.result),
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
                _buildProductImagesWidgets(result.image),
                _buildProductTitleWidget(result.title),
                SizedBox(height: 12.0),
                _buildPriceWidgets(result.price),
                SizedBox(height: 12.0),
                _buildDivider(screenSize),
                SizedBox(height: 12.0),
                // _buildFurtherInfoWidget(),
                // SizedBox(height: 12.0),
                // _buildDivider(screenSize),
                // SizedBox(height: 12.0),
                // _buildSizeChartWidgets(),
                // SizedBox(height: 12.0),
                _buildDetailsAndMaterialWidgets(),
                SizedBox(height: 12.0),
                _buildDivider(screenSize),
                SizedBox(height: 12.0),
                _buildStyleNoteHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildStyleNoteData(),
                SizedBox(height: 20.0),
                _buildMoreInfoHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildMoreInfoData(),
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

  _buildProductImagesWidgets(String image) {
    TabController imagesController = TabController(length: 1, vsync: this);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 250.0,
        child: Center(
          child: DefaultTabController(
            length: 3,
            child: Stack(
              children: <Widget>[
                TabBarView(
                  controller: imagesController,
                  children: <Widget>[
                    Image.network(image),
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

  _buildFurtherInfoWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.local_offer,
            color: Colors.grey[500],
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "Tap to get further info",
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  _buildSizeChartWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.straighten,
                color: Colors.grey[600],
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                "Size",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Text(
            "SIZE CHART",
            style: TextStyle(
              color: Colors.blue[400],
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  _buildDetailsAndMaterialWidgets() {
    TabController tabController = new TabController(length: 2, vsync: this);
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
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            height: 200.0,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                Text(
                  "бла бла",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  "бла бла харак",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
              ],
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

  _buildStyleNoteData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        " ",
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
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

  _buildMoreInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        " ",
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
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
