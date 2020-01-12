import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/shop/sub_category_detail/index.dart';
import 'package:wmn_plus/features/shop/widgets/product_list.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({
    Key key,
    @required CategoryDetailBloc categoryDetailBloc,
    @required int id,
  })  : _categoryDetailBloc = categoryDetailBloc,
        _id = id,
        super(key: key);

  final CategoryDetailBloc _categoryDetailBloc;
  final int _id;

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
    this._load(widget._id);
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
                    onPressed: () => this._load(1),
                  ),
                ),
              ],
            ));
          }
          if (currentState is InCategoryDetailState)
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: currentState.hello.result.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            
                              ProductList(
                                id: widget._id, //cat
                                sub: currentState.hello.result[index].id,
                                products:
                                    currentState.hello.result[index].products,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
        });
  }

  void _load(int id) {
    widget._categoryDetailBloc.add(UnCategoryDetailEvent());
    widget._categoryDetailBloc.add(LoadCategoryDetailEvent(id));
  }
}
