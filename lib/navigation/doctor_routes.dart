import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/auth/ui/page/profile_page.dart';
import 'package:wmn_plus/features/news/news_page.dart';
import 'package:wmn_plus/locale/app_localization.dart';
import 'package:wmn_plus/navigation/bottom_navigation.dart';
import 'package:wmn_plus/util/config.dart';

ThemeData THEME = ThemeData(
  textTheme: TextTheme(
    // --- APP BAR TEXT STYLE
    title: TextStyle(
        fontSize: ScreenUtil().setSp(65),
        color: Colors.white,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2),
  ),
  accentColor: Color(0xff474DDF),
  primaryColor: Color(0xff474DDF),
);

class AuthenticatedDoctorRoutes extends StatelessWidget {
  Widget buildRoutes(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: THEME,
      routes: {
        '/': (BuildContext context) =>
            BottomNavigation(pageOptions: pageOptions, barItems: barItems),
      },
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

final List pageOptions = [
  NewsPage(),
  ProfilePage(),
];

final List<BottomNavigationBarItem> barItems = [
  // --- NEWS PAGE
  BottomNavigationBarItem(
    icon: Icon(Icons.list),
    title: Text('Новости'),
  ),
  // --- PROFILE PAGE
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    title: Text('Профиль'),
  ),
];
