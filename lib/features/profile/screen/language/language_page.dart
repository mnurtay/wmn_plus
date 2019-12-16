import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/profile/screen/language/index.dart';

class LanguagePage extends StatelessWidget {
  static const String routeName = '/language';


  @override
  Widget build(BuildContext context) {
    var languageBloc = LanguageBloc();
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).tr('settings.language_settings')),
          ),
          body: LanguageScreen(languageBloc: languageBloc,data: data)),
    );
  }
}
