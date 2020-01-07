
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../fertility_calendar_model.dart';

class RedHeader extends StatelessWidget {
  const RedHeader({
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
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Месячные",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(80),
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            ),
            Text(
              result.info.currentFert.toString() + " день",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(90),
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
