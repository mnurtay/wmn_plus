import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/util/config.dart';

ThemeData THEME_MODE_DOCTOR = ThemeData(
  accentColor: Color(0xff474DDF),
  primaryColor: Color(0xff474DDF),
);

class AuthenticatedDoctorRoutes extends StatelessWidget {
  Widget buildRoutes(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: THEME_MODE_DOCTOR,
      routes: {},
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: DEVICE_WIDTH, height: DEVICE_HEIGHT, allowFontScaling: true)
      ..init(context);
    return buildRoutes(context);
  }
}
