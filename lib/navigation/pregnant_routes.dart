import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/auth/ui/page/profile_page.dart';
import 'package:wmn_plus/features/consultation/ui/page/chat_list_page.dart';
import 'package:wmn_plus/features/consultation/ui/page/new_consultation_page.dart';
import 'package:wmn_plus/features/news/index.dart';
import 'package:wmn_plus/locale/app_localization.dart';
import 'package:wmn_plus/navigation/bottom_navigation.dart';
import 'package:wmn_plus/util/config.dart';

ThemeData THEME = ThemeData(
  textTheme: TextTheme(
    // --- APP BAR TEXT STYLE
    title: TextStyle(
        fontSize: ScreenUtil().setSp(65),
        color: Colors.black,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2),
    display1: TextStyle(
        fontSize: ScreenUtil().setSp(60),
        fontWeight: FontWeight.w500,
        color: Colors.black,
        letterSpacing: 0.1),
    display2: TextStyle(
        fontSize: ScreenUtil().setSp(40),
        fontWeight: FontWeight.w400,
        color: Colors.grey,
        letterSpacing: 0.1),
    // --- DEFAULT STYLE
    body1: TextStyle(
        fontSize: ScreenUtil().setSp(50),
        fontWeight: FontWeight.w400,
        color: Colors.black),
    body2: TextStyle(
        color: Colors.black,
        fontSize: ScreenUtil().setSp(50),
        fontWeight: FontWeight.w500),
  ),
  accentColor: Color(0xffD748DA),
  primaryColor: Color(0xffD748DA),
);

class AuthenticatedPregnantRoutes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PregnantRoutes();
}

class _PregnantRoutes extends State<AuthenticatedPregnantRoutes> {
  AppLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState() {
    _localeOverrideDelegate = AppLocalizationDelegate(Locale('ru', 'RU'));
    super.initState();
  }

  Widget buildRoutes(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        _localeOverrideDelegate
      ],
      supportedLocales: [
        const Locale('ru', 'RU'),
        const Locale('en', 'US'),
        const Locale('kz', 'KZ'),
      ],
      debugShowCheckedModeBanner: false,
      theme: THEME,
      routes: {
        '/': (BuildContext context) =>
            BottomNavigation(pageOptions: pageOptions, barItems: barItems),
        '/new_consultation': (BuildContext context) => NewConsultationPage(),
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
  ProfilePage(),
  ProfilePage(),
  ChatListPage(),
  ProfilePage(),
];

final List<BottomNavigationBarItem> barItems = [
  // --- NEWS PAGE
  BottomNavigationBarItem(
    icon: Icon(Icons.list),
    title: Text('Новости'),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.calendar_today),
    title: Text('Календарь'),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shop_two),
    title: Text('Cкидки и Акции'),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shopping_cart),
    title: Text('Магазин'),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.chat),
    title: Text('Консультация'),
  ),
  // --- PROFILE PAGE
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    title: Text('Профиль'),
  ),
];