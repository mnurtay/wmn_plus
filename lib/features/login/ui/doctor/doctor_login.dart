import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/auth/bloc/bloc.dart';
import 'package:wmn_plus/features/login/bloc/bloc.dart';
import 'package:wmn_plus/features/login/ui/page/doctor_login_form.dart';

class DoctorLoginPage extends StatefulWidget {
  @override
  _DoctorLoginPageState createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
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
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                color: Colors.white,
              ),
              Container(
                height: 200,
                child: Image.asset("assets/doctor_login_logo.png"),
              ),
              DoctorLoginForm(
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
