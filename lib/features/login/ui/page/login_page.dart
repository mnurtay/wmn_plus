import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/auth/bloc/bloc.dart';
import 'package:wmn_plus/features/login/bloc/bloc.dart';
import 'package:wmn_plus/features/login/ui/page/login_form.dart';
import 'package:wmn_plus/features/login/ui/page/login_title.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc _authBloc;
  LoginBloc _loginBloc;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _loginBloc = LoginBloc(authBloc: _authBloc);
    
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Stack(
          children: <Widget>[
            buildContent(),
          ],
        ),
      ),
    );
  }

  buildContent() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                height: ScreenUtil.getInstance().setHeight(700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Добро пожаловать в",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(80),
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "WMN+",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(90),
                        fontWeight: FontWeight.w400,
                        color: Color(0xffD748DA),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // LoginTitle(),
              LoginForm(
                authBloc: _authBloc,
                loginBloc: _loginBloc,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
