import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    final titleStyle = TextStyle(
        fontFamily: 'SFProText-Medium',
        color: Colors.black,
        fontSize: ScreenUtil.getInstance().setSp(45),
        fontWeight: FontWeight.w500,
        letterSpacing: 0);
    return Container(
      height: 200,
      child: Image.asset("assets/login_logo.png"),
    );
  }
}
