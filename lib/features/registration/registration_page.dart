import 'package:flutter/material.dart';
import 'package:wmn_plus/features/registration/index.dart';

class RegistrationPage extends StatelessWidget {
  static const String routeName = '/registration';

  @override
  Widget build(BuildContext context) {
    var _registrationBloc = RegistrationBloc();
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      body: RegistrationScreen(
        registrationBloc: _registrationBloc,
        scaffoldKey: _scaffoldKey,
      ),
    );
  }
}
