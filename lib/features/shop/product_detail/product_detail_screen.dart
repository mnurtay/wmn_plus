import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/shop/product_detail/index.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    Key key,
    @required ProductDetailBloc productDetailBloc,
  })  : _productDetailBloc = productDetailBloc,
        super(key: key);

  final ProductDetailBloc _productDetailBloc;

  @override
  ProductDetailScreenState createState() {
    return ProductDetailScreenState(_productDetailBloc);
  }
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailBloc _productDetailBloc;
  ProductDetailScreenState(this._productDetailBloc);

  @override
  void initState() {
    super.initState();
    this._load();
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
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ));
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Flutter files: done'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.red,
                    child: Text('throw error'),
                    onPressed: () => this._load(true),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _load([bool isError = false]) {
    widget._productDetailBloc.add(UnProductDetailEvent());
    widget._productDetailBloc.add(LoadProductDetailEvent(isError));
  }
}
