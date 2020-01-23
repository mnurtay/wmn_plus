import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/auth/ui/page/profile_page.dart';
import 'package:wmn_plus/features/consultation/ui/page/chat_list_page.dart';
import 'package:wmn_plus/features/consultation/ui/page/chat_page.dart';
import 'package:wmn_plus/features/news/news_page.dart';
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
  accentColor: Color(0xff474DDF),
  primaryColor: Color(0xff474DDF),
);

class AuthenticatedDoctorRoutes extends StatelessWidget {
  List<String> _category = ['Для докторам'];
  List<int> _categoryId = [22];

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
          locale: data.locale,
          debugShowCheckedModeBanner: false,
          theme: THEME,
          routes: {
            '/': (BuildContext context) => BottomNavigation(
                modeColor: Theme.of(context).accentColor,
                pageOptions: pageOptions(context),
                barItems: barItems(context)),
          },
          onGenerateRoute: (RouteSettings settings) {
            if (settings.name == '/chat_page') {
              Map object = settings.arguments;
              return MaterialPageRoute(
                builder: (BuildContext context) => ChatPage(
                  consultation: object['consultation'],
                  currentUser: object['user'],
                  role: object['type'],
                  fullName: object['full_name'],
                ),
              );
            }
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: DEVICE_WIDTH, height: DEVICE_HEIGHT, allowFontScaling: true)
      ..init(context);
    return buildRoutes(context);
  }

  List pageOptions(BuildContext context) {
    return [
      NewsPage(_category, _categoryId),
      ChatListPage(type: "doctor"),
      ProfilePage(),
    ];
  }

  List<Widget> barItems(BuildContext context) {
    return [
      // NEWS
      Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(5)),
        child: Icon(Icons.list),
      ),
      Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(5)),
        child: Icon(Icons.chat),
      ),
      // PROFILE
      Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(5)),
        child: Icon(Icons.person),
      ),
    ];
  }
}
