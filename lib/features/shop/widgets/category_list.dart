import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/shop/category_detail/category_detail_page.dart';
import 'package:wmn_plus/features/shop/shop_state.dart';
import 'package:wmn_plus/features/shop/widgets/category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key key,
    @required this.currentState,
  }) : super(key: key);

  final InShopState currentState;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: currentState.hello.result.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(currentState.hello.result[index].title,
                        style: Theme.of(context).textTheme.title),
                    Expanded(
                      child: Container(),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, CategoryDetailPage.routeName,
                            arguments: 1);
                      },
                      child: Text(
                        "Все",
                        style: TextStyle(color: Color(0xff0CB19A4)),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xff0CB19A4))),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(15),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          currentState.hello.result[index].products.length,
                      itemBuilder: (context, index) {
                        return CatergoryItem(
                            product: currentState
                                .hello.result[index].products[index]);
                      }),
                ),
              ],
            );
          }),
    );
  }
}
