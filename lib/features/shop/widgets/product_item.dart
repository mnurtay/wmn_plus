import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/shop/sub_category_detail/category_detail_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
    Products product, {
    Key key,
  })  : _products = product,
        super(key: key);
  final Products _products;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      width: ScreenUtil.getInstance().setWidth(250),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(12),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this._products.title,
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(32),
                        fontWeight: FontWeight.w500)),
                Row(
                  children: <Widget>[
                    Text(this._products.price.toString(),
                        style: TextStyle(
                            color: Color(0xff0CB19A4),
                            fontSize: ScreenUtil.getInstance().setSp(34),
                            fontWeight: FontWeight.bold)),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xff0CB19A4),
                      size: 16.0,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
