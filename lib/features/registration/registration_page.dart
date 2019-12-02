import 'package:flutter/material.dart';
import 'package:wmn_plus/features/registration/index.dart';

class RegistrationPage extends StatelessWidget {
  static const String routeName = '/registration';

  @override
  Widget build(BuildContext context) {
    var _registrationBloc = RegistrationBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: RegistrationScreen(registrationBloc: _registrationBloc),
    );
  }
}
