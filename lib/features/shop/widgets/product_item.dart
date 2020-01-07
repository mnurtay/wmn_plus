import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
  }) : super(key: key);

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
                Text("Куртка",
                    style:
                        TextStyle(fontSize: ScreenUtil.getInstance().setSp(32), fontWeight: FontWeight.w500)),
                Row(
                  children: <Widget>[
                    Text("12 990 тг",
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
