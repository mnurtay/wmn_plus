import 'package:flutter/material.dart';
import 'package:wmn_plus/features/registration/registration_mode/index.dart';

class RegistrationModePage extends StatelessWidget {
  static const String routeName = '/registrationMode';

  @override
  Widget build(BuildContext context) {
    var _registrationModeBloc = RegistrationModeBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите режим'),
      ),
      body: RegistrationModeScreen(registrationModeBloc: _registrationModeBloc),
    );
  }
}
