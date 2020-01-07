import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/shop/category_detail/index.dart';
import 'package:wmn_plus/features/shop/widgets/product_list.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({
    Key key,
    @required CategoryDetailBloc categoryDetailBloc,
  })  : _categoryDetailBloc = categoryDetailBloc,
        super(key: key);

  final CategoryDetailBloc _categoryDetailBloc;

  @override
  CategoryDetailScreenState createState() {
    return CategoryDetailScreenState(_categoryDetailBloc);
  }
}

class CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final CategoryDetailBloc _categoryDetailBloc;
  CategoryDetailScreenState(this._categoryDetailBloc);

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
    return BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
        bloc: widget._categoryDetailBloc,
        builder: (
          BuildContext context,
          CategoryDetailState currentState,
        ) {
          if (currentState is UnCategoryDetailState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorCategoryDetailState) {
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Мамам", style: Theme.of(context).textTheme.title),
                SizedBox(
                  height: 15,
                ),
                ProductList(
                  currentState: currentState,
                ),
              ],
            ),
          );
        });
  }

  void _load([bool isError = false]) {
    widget._categoryDetailBloc.add(UnCategoryDetailEvent());
    widget._categoryDetailBloc.add(LoadCategoryDetailEvent(isError));
  }
}
