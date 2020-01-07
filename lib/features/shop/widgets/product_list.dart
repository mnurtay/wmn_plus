import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/shop/category_detail/category_detail_state.dart';
import 'package:wmn_plus/features/shop/widgets/product_item.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key key,
    @required this.currentState,
  }) : super(key: key);

  final InCategoryDetailState currentState;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("sss", style: Theme.of(context).textTheme.title),
                    Expanded(
                      child: Container(),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Посмотреть",
                        style: TextStyle(color: Color(0xff0CB19A4)),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xff0CB19A4))),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(20),
                ),
                Container(
                  height: ScreenUtil.getInstance().setHeight(400),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ProductItem();
                      }),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(20),
                ),
              ],
            );
          }),
    );
  }
}
