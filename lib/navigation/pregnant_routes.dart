import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/auth/ui/page/profile_page.dart';
import 'package:wmn_plus/features/consultation/ui/page/chat_list_page.dart';
import 'package:wmn_plus/features/consultation/ui/page/chat_page.dart';
import 'package:wmn_plus/features/consultation/ui/page/doctors_list_page.dart';
import 'package:wmn_plus/features/consultation/ui/page/new_consultation_page.dart';
import 'package:wmn_plus/features/discounts/discounts_page.dart';
import 'package:wmn_plus/features/news/index.dart';
import 'package:wmn_plus/features/news/news_detail/index.dart';
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
    display3: TextStyle(
        fontSize: ScreenUtil().setSp(60),
        fontWeight: FontWeight.w800,
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
  @override
  void initState() {
    super.initState();
  }

  Widget buildRoutes(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          //app-specific localization
          EasylocaLizationDelegate(locale: data.locale, path: 'path'),
        ],
        supportedLocales: [
          Locale('ru', 'RU'),
          Locale('en', 'US'),
          Locale('kk', 'KZ')
        ],
        locale: data.savedLocale,
        debugShowCheckedModeBanner: false,
        theme: THEME,
        routes: {
          '/': (BuildContext context) => BottomNavigation(
              pageOptions: pageOptions, barItems: barItems(context)),
          '/new_consultation': (BuildContext context) => NewConsultationPage(),
          '/news_detail': (BuildContext context) => NewsDetailPage(),
          '/discounts': (BuildContext context) => DiscountsPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == '/doctors_list') {
            return MaterialPageRoute(
                builder: (BuildContext context) =>
                    DoctorsListPage(category: settings.arguments));
          }
          if (settings.name == '/chat_page') {
            return MaterialPageRoute(
                builder: (BuildContext context) =>
                    ChatPage(doctor: settings.arguments));
          }
          return null;
        },
      ),
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
  DiscountsPage(),
  ProfilePage(),
  ChatListPage(),
  ProfilePage(),
];

List<BottomNavigationBarItem> barItems(BuildContext context) {
  return [
    // --- NEWS PAGE
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      title: Text(AppLocalizations.of(context).tr('news')),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      title: Text(AppLocalizations.of(context).tr('calendar')),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shop_two),
      title: Text(AppLocalizations.of(context).tr('discount')),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      title: Text(AppLocalizations.of(context).tr('shop')),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat),
      title: Text(AppLocalizations.of(context).tr('chat')),
    ),
    // --- PROFILE PAGE
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text(AppLocalizations.of(context).tr('profil')),
    ),
  ];
}
