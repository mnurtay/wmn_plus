import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/shop/index.dart';
import 'package:wmn_plus/features/shop/widgets/category_list.dart';
import 'package:wmn_plus/features/shop/widgets/recommended_product_item.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({
    Key key,
    @required ShopBloc shopBloc,
  })  : _shopBloc = shopBloc,
        super(key: key);

  final ShopBloc _shopBloc;

  @override
  ShopScreenState createState() {
    return ShopScreenState(_shopBloc);
  }
}

class ShopScreenState extends State<ShopScreen> {
  final ShopBloc _shopBloc;
  ShopScreenState(this._shopBloc);

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
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    return BlocBuilder<ShopBloc, ShopState>(
        bloc: widget._shopBloc,
        builder: (
          BuildContext context,
          ShopState currentState,
        ) {
          if (currentState is UnShopState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorShopState) {
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
          if (currentState is InShopState) {
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Theme.of(context).accentColor, Colors.blue])),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(20),
                    ),
                    CategoryListWidget(
                      currentState: currentState,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  void _load([bool isError = false]) {
    widget._shopBloc.add(UnShopEvent());
    widget._shopBloc.add(LoadShopEvent(isError));
  }
}
