import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../fertility_calendar_model.dart';

class BlueHeader extends StatelessWidget {
  const BlueHeader({
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
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "У вас есть возможность забеременеть",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(60),
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, "/change_mode_fertility");
                  },
                    child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
