import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/shop/shop_state.dart';
import 'package:wmn_plus/features/shop/sub_category_detail/category_detail_page.dart';
import 'package:wmn_plus/features/shop/widgets/category_item.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
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
          itemBuilder: (context, indexCategory) {
            if (currentState.hello.result[indexCategory].subcategories.length ==
                0) return Container();
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(currentState.hello.result[indexCategory].title,
                        style: TextStyle(
                            shadows: <Shadow>[
                              // Shadow(
                              //   offset: Offset(1.0, 1.0),
                              //   blurRadius: 2.0,
                              //   color: Color.fromARGB(255, 0, 0, 0),
                              // ),
                            ],
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    Expanded(
                      child: Container(),
                    ),
                    FlatButton(
                      onPressed: () {
                        Map<String, dynamic> route = Map();
                        route["id"] =
                            currentState.hello.result[indexCategory].id;
                        route["title"] =
                            currentState.hello.result[indexCategory].title;
                        Navigator.pushNamed(
                            context, CategoryDetailPage.routeName,
                            arguments: route);
                      },
                      child: Text(
                        "Все",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff0CB19A4)),
                      ),
                      color: Colors.white,
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
                      itemCount: currentState
                          .hello.result[indexCategory].subcategories.length,
                      itemBuilder: (context, index) {
                        return CatergoryItem(
                            id: currentState.hello.result[indexCategory].id,
                            subcategories: currentState.hello
                                .result[indexCategory].subcategories[index]);
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
