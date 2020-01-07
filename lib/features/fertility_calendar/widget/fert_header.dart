import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../fertility_calendar_model.dart';

class FertHeader extends StatelessWidget {
  const FertHeader({
    Key key,
    @required this.context,
    @required this.result,
  }) : super(key: key);

  final BuildContext context;
  final Result result;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(400),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "До месячных осталось",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(60),
                fontWeight: FontWeight.w200,
                color: Colors.black,
              ),
            ),
            Text(
              result.info.toFert.toString() + " дни",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(90),
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
