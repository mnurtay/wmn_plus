import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/registration/registration_mode/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

class RegistrationModePage extends StatelessWidget {
  static const String routeName = '/registrationMode';
  RegistrationModel registrationModel;
  RegistrationModePage(this.registrationModel);
  @override
  Widget build(BuildContext context) {
    var _authBloc = BlocProvider.of<AuthBloc>(context);
    var _registrationModeBloc = RegistrationModeBloc(authBloc: _authBloc);
    return Scaffold(
      body: RegistrationModeScreen(
        registrationModeBloc: _registrationModeBloc,
        registrationModel: registrationModel,
      ),
    );
  }
}
