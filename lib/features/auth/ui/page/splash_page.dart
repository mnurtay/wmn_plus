import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmn_plus/features/auth/bloc/bloc.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/util/config.dart';

class SplashScreen extends StatefulWidget {
  final data;
  SplashScreen(this.data);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthBloc _authBloc;
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    // User user = await UserRepository().getCurrentUser();
    // String mode = user.result?.regime;

    if (_seen) {
      print("not first");
    } else {
      setState(() {
        prefs.setBool('seen', true);
        widget.data.changeLocale(Locale("ru", "RU"));
      });
    }
  }

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);

    checkFirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: DEVICE_WIDTH, height: DEVICE_HEIGHT, allowFontScaling: true)
      ..init(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Slash Page',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(75),
            letterSpacing: 0.1,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
