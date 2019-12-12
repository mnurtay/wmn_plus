import 'package:flutter/material.dart';
import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/fertility_duration/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

class FertilityDurationPage extends StatelessWidget {
  static const String routeName = '/fertilityDuration';
  RegistrationModel registrationModel;

  FertilityDurationPage(this.registrationModel);
  @override
  Widget build(BuildContext context) {
    var _fertilityDurationBloc = FertilityDurationBloc();
    return Scaffold(
      body: FertilityDurationScreen(
          fertilityDurationBloc: _fertilityDurationBloc,
          registrationModel: registrationModel),
    );
  }
}
