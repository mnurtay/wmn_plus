import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSettings extends StatefulWidget {
  @override
  _LanguageSettingsState createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  static Widget _buildCard({String title, String image, Function change}) =>
      Card(
        margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setSp(30)),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
          ),
          leading:
              Image.asset(image, width: ScreenUtil.getInstance().setSp(90)),
          onTap: change,
        ),
      );

  Widget languageList(BuildContext context, data) => Container(
      margin: EdgeInsets.only(top: ScreenUtil.getInstance().setSp(20)),
      child: ListView(
        children: <Widget>[
          _buildCard(
            title: 'Қазақша',
            image: 'assets/kazakhstan.png',
            change: () {
              setState(() {
                data.changeLocale(Locale("kk", "KZ"));
              });
              Navigator.pop(context);
            },
          ),
          _buildCard(
            title: 'Русский',
            image: 'assets/russia.png',
            change: () {
              setState(() {
                data.changeLocale(Locale("ru", "RU"));
              });
              Navigator.pop(context);
            },
          ),
          _buildCard(
            title: 'English',
            image: 'assets/united-kingdom.png',
            change: () {
              setState(() {
                data.changeLocale(Locale("en", "US"));
              });
              Navigator.pop(context);
            },
          ),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).tr('settings.language_settings'),),
          ),
          body: languageList(context, data)),
    );
  }
}
