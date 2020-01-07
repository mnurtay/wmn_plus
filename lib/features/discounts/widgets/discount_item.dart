import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../discounts_model.dart';

class DiscountItem extends StatelessWidget {
  const DiscountItem({
    Key key,
    @required this.context,
    @required this.result,
  }) : super(key: key);

  final BuildContext context;
  final Result result;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(result.id.toString());
        Navigator.pushNamed(context, '/discount_detail',
            arguments: result.id.toString());
      },
      child: Container(
          margin:
              EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(25)),
          height: ScreenUtil.getInstance().setHeight(600),
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Text(
                        result.title,
                        style: Theme.of(context).textTheme.body2,
                      ),
                      top: ScreenUtil.getInstance().setHeight(40),
                      left: ScreenUtil.getInstance().setHeight(30),
                    ),
                    Positioned(
                      child: Text("Просмотрено: 99",
                          style: Theme.of(context).textTheme.display2),
                      top: ScreenUtil.getInstance().setHeight(170),
                      left: ScreenUtil.getInstance().setHeight(30),
                    ),
                    Positioned(
                      child: Text("от 1 100 тг.",
                          style: Theme.of(context).textTheme.display3),
                      bottom: ScreenUtil.getInstance().setHeight(70),
                      right: ScreenUtil.getInstance().setHeight(30),
                    ),
                    Positioned(
                      child: Text("экономия от 2500 тг.",
                          style: Theme.of(context).textTheme.display2),
                      bottom: ScreenUtil.getInstance().setHeight(30),
                      right: ScreenUtil.getInstance().setHeight(30),
                    ),
                  ],
                ),
                height: ScreenUtil.getInstance().setHeight(250),
                decoration: BoxDecoration(
                    color: Colors.white,
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
                  fit: BoxFit.fill, image: NetworkImage(result.imageUrl)))),
    );
  }
}
