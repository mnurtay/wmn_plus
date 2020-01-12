import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/shop/sub_category_detail/index.dart';
import 'package:wmn_plus/features/shop/sub_category_products/index.dart';
import 'package:wmn_plus/features/shop/widgets/product_list_widget.dart';

class SubCategoryProductsScreen extends StatefulWidget {
  const SubCategoryProductsScreen({
    Key key,
    @required SubCategoryProductsBloc subCategoryProductsBloc,
    @required Map<String, dynamic> map,
  })  : _subCategoryProductsBloc = subCategoryProductsBloc,
        _map = map,
        super(key: key);

  final SubCategoryProductsBloc _subCategoryProductsBloc;
  final Map<String, dynamic> _map;
  @override
  SubCategoryProductsScreenState createState() {
    return SubCategoryProductsScreenState(_subCategoryProductsBloc);
  }
}

class SubCategoryProductsScreenState extends State<SubCategoryProductsScreen> {
  final SubCategoryProductsBloc _subCategoryProductsBloc;
  SubCategoryProductsScreenState(this._subCategoryProductsBloc);

  @override
  void initState() {
    super.initState();
    this._load(widget._map["cat"], widget._map["sub"]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubCategoryProductsBloc, SubCategoryProductsState>(
        bloc: widget._subCategoryProductsBloc,
        builder: (
          BuildContext context,
          SubCategoryProductsState currentState,
        ) {
          if (currentState is UnSubCategoryProductsState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorSubCategoryProductsState) {
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
                    onPressed: () => this._load(1, 1),
                  ),
                ),
              ],
            ));
          }
          if (currentState is InSubCategoryProductsState)
            return ProductListWidget(
              cat: widget._map["cat"],
              sub: widget._map["sub"],
              productList: currentState.hello,
            );

        });
  }

  void _load(int cat, int sub) {
    widget._subCategoryProductsBloc.add(UnSubCategoryProductsEvent());
    widget._subCategoryProductsBloc.add(LoadSubCategoryProductsEvent(cat, sub));
  }
}
