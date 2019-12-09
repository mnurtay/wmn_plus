import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/fertility_period/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

class FertilityPeriodPage extends StatelessWidget {
  static const String routeName = '/fertilityPeriod';
  
  RegistrationModel registrationModel;

  FertilityPeriodPage(this.registrationModel);
  @override
  Widget build(BuildContext context) {
    var _authBloc = BlocProvider.of<AuthBloc>(context);
    var _fertilityPeriodBloc = FertilityPeriodBloc(authBloc: _authBloc);
    return Scaffold(
      body: FertilityPeriodScreen(fertilityPeriodBloc: _fertilityPeriodBloc, registrationModel: registrationModel),
    );
  }
}
