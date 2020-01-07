import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationHeader extends StatelessWidget {
  const RegistrationHeader({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              child: Center(
                  child: Text(
                "1",
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(40)),
              )),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16.0)),
              height: 60,
              width: 50,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Expanded(
          child: Container(),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            child: Text("Назад"),
          ),
        ),
      ],
    );
  }
}
