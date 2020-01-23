import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wmn_plus/features/consultation/ui/page/chat_list_page.dart';
import 'package:wmn_plus/features/consultation/ui/page/chat_page.dart';
import 'package:wmn_plus/features/consultation/ui/page/consultation_payment_page.dart';
import 'package:wmn_plus/features/consultation/ui/page/doctor_page.dart';
import 'package:wmn_plus/features/consultation/ui/page/doctors_list_page.dart';
import 'package:wmn_plus/features/consultation/ui/page/new_consultation_page.dart';
import 'package:wmn_plus/features/discounts/discount_detail/discount_detail_page.dart';
import 'package:wmn_plus/features/discounts/discounts_page.dart';
import 'package:wmn_plus/features/fertility_calendar/fertility_calendar_page.dart';
import 'package:wmn_plus/features/news/news_detail/news_detail_page.dart';
import 'package:wmn_plus/features/news/news_page.dart';
import 'package:wmn_plus/features/profile/about_us/about_us_page.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/change_mode_fertility_duration/change_mode_fertility_duration_page.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/change_mode_fertility_page.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/change_mode_fertility_period/change_mode_fertility_period_page.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_page.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_pregnancy/index.dart';
import 'package:wmn_plus/features/profile/profile_page.dart';
import 'package:wmn_plus/features/profile/screen/faq/faq.dart';
import 'package:wmn_plus/features/profile/screen/language/language_page.dart';
import 'package:wmn_plus/features/registration/registration_mode/registration_mode_page.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';
import 'package:wmn_plus/features/shop/buy_product/buy_product_page.dart';
import 'package:wmn_plus/features/shop/sub_category_detail/index.dart';
import 'package:wmn_plus/features/shop/product_detail/product_detail_page.dart';
import 'package:wmn_plus/features/shop/shop_page.dart';
import 'package:wmn_plus/features/shop/sub_category_products/sub_category_products_page.dart';
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
  accentColor: Color(0xff5b59ba),
  primaryColor: Color(0xff7b7ac7),
);

class AuthenticatedFertilityRoutes extends StatelessWidget {
  List<String> _category = [
    'Менструальный цикл',
    'Личная гигиена',
    'Контрацепция',
    'Все о гормонах ',
    'Заболевания "по-женски"',
    'Женская консультация',
    'Полезные советы',
  ];

  List<int> _categoryId = [10, 11, 12, 13, 14, 15, 16];

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
          '/new_consultation': (BuildContext context) => NewConsultationPage(),
          '/discounts': (BuildContext context) => DiscountsPage(),
          '/settings_language': (BuildContext context) => LanguagePage(),
          '/profile': (BuildContext context) => ProfilPage(),
          '/news': (BuildContext context) => NewsPage(_category, _categoryId),
          '/faq': (BuildContext context) => FAQ(),
          '/settings_change_mode': (BuildContext context) => ChangeModePage(),
          '/change_mode_fertility': (BuildContext context) =>
              ChangeModeFertilityPage(),
          '/change_mode_pregnancy': (BuildContext context) =>
              ChangeModePregnancyPage(),
          '/about_us': (BuildContext context) => AboutUs()
        },
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == CategoryDetailPage.routeName) {
            return PageTransition(
              child: CategoryDetailPage(settings.arguments),
              type: PageTransitionType.scale,
              settings: settings,
            );
          }
          if (settings.name == SubCategoryProductsPage.routeName) {
            return PageTransition(
              child: SubCategoryProductsPage(settings.arguments),
              type: PageTransitionType.rotate,
              settings: settings,
            );
          }

          if (settings.name == ProductDetailPage.routeName) {
            return PageTransition(
              child: ProductDetailPage(settings.arguments),
              type: PageTransitionType.leftToRightWithFade,
              settings: settings,
            );
          }

          if (settings.name == BuyProductPage.routeName) {
            return PageTransition(
              child: BuyProductPage(settings.arguments),
              type: PageTransitionType.rightToLeftWithFade,
              settings: settings,
            );
          }
          if (settings.name == '/news_detail') {
            return MaterialPageRoute(
                builder: (BuildContext context) =>
                    NewsDetailPage(settings.arguments));
          }
          if (settings.name == '/discount_detail') {
            return MaterialPageRoute(
                builder: (BuildContext context) =>
                    DiscountDetailPage(settings.arguments));
          }
          if (settings.name == '/doctors_list') {
            return MaterialPageRoute(
                builder: (BuildContext context) =>
                    DoctorsListPage(category: settings.arguments));
          }
          if (settings.name == '/chat_page') {
            Map object = settings.arguments;
            return MaterialPageRoute(
              builder: (BuildContext context) => ChatPage(
                consultation: object['consultation'],
                currentUser: object['user'],
              ),
            );
          }
          if (settings.name == '/doctor_page') {
            return MaterialPageRoute(
                builder: (BuildContext context) =>
                    DoctorPage(doctor: settings.arguments));
          }
          if (settings.name == '/consultation_payment') {
            return MaterialPageRoute(
                builder: (BuildContext context) =>
                    ConsulatationPaymentPage(url: settings.arguments));
          }
          if (settings.name == '/change_mode_fertility_duration') {
            return MaterialPageRoute(
                builder: (BuildContext context) =>
                    ChangeModeFertilityDurationPage(settings.arguments));
          }
          if (settings.name == '/change_mode_fertility_period') {
            return MaterialPageRoute(
                builder: (BuildContext context) =>
                    ChangeModeFertilityPeriodPage(settings.arguments));
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

  List pageOptions(BuildContext context) {
    return [
      NewsPage(_category, _categoryId),
      ChatListPage(),
      FertilityCalendarPage(),
      DiscountsPage(),
      ShopPage(),
      ProfilPage(),
    ];
  }

  List<Widget> barItems(BuildContext context) {
    return [
      // NEWS
      Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(5)),
        child: Icon(Icons.list),
      ),
      // CHAT
      Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(5)),
        child: Icon(Icons.chat),
      ),
      //CALENDAR
      Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(5)),
        child: Icon(Icons.calendar_today),
      ),
      // DISCOUNTS
      Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(5)),
        child: Icon(Icons.shopping_cart),
      ),
      Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(5)),
        child: Icon(Icons.shopping_basket),
      ),
      // PROFILE
      Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(5)),
        child: Icon(Icons.person),
      ),
    ];
  }
}
