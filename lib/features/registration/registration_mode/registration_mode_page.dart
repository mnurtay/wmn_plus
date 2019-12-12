import 'package:flutter/material.dart';
import 'package:wmn_plus/features/registration/registration_mode/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

class RegistrationModePage extends StatelessWidget {
  static const String routeName = '/registrationMode';
  RegistrationModel registrationModel;
  RegistrationModePage(this.registrationModel);
  @override
  Widget build(BuildContext context) {
    var _registrationModeBloc = RegistrationModeBloc();
    return Scaffold(
      body: RegistrationModeScreen(
        registrationModeBloc: _registrationModeBloc,
        registrationModel: registrationModel,
      ),
    );
  }
}
