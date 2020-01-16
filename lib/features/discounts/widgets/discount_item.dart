import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../discounts_model.dart';

class DiscountItem extends StatelessWidget {
  const DiscountItem({
    Key key,
    @required this.catId,
    @required this.context,
    @required this.result,
  }) : super(key: key);

  final BuildContext context;
  final Result result;
  final int catId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Map<String, int> route = Map();
        route["catId"] = this.catId;
        route["disId"] = this.result.id;
        Navigator.pushNamed(context, '/discount_detail', arguments: route);
      },
      child: Container(
          margin:
              EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(25)),
          height: 230,
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        result.title.trim(),
                        style: Theme.of(context).textTheme.body2,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Просмотрено: ${result.watched} раз",
                        style: Theme.of(context).textTheme.display2,
                      ),
                    ],
                  ),
                ),
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1, //                   <--- border width here
                    ),
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                        bottom: Radius.circular(10)))),
            decoration: BoxDecoration(
                color: Colors.black38, borderRadius: BorderRadius.circular(10)),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(result.images[0])))),
    );
  }
}
