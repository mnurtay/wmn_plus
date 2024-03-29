import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../fertility_calendar_model.dart';

class PMSHeader extends StatelessWidget {
  const PMSHeader({
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
              "До ПМС осталось",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(80),
                fontWeight: FontWeight.w200,
                color: Colors.black,
              ),
            ),
            Text(
              dayString(result.info.toPMS),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(90),
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/change_mode_fertility");
                    },
                    child: Icon(
                      Icons.settings,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  String dayString(int day) {
    if (day == 1) {
      return "$day день";
    } else if (1 < day && day < 5) {
      return "$day дня";
    } else {
      return "$day дни";
    }
  }
}
