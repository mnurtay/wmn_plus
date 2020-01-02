import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/registration/registration_mode/pregnant_mode/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

class PregnantModePage extends StatelessWidget {
  static const String routeName = '/pregnantMode';
RegistrationModel registrationModel;
PregnantModePage(this.registrationModel);
  @override
  Widget build(BuildContext context) {
    var _authBloc = BlocProvider.of<AuthBloc>(context);
    var _pregnantModeBloc = PregnantModeBloc(authBloc: _authBloc);
    
    return Scaffold(
      body: PregnantModeScreen(pregnantModeBloc: _pregnantModeBloc, registrationModel: registrationModel),
    );
  }
}
