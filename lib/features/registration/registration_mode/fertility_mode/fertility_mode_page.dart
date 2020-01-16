import 'package:flutter/material.dart';
import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

class FertilityModePage extends StatelessWidget {
  static const String routeName = '/fertilityMode';
  RegistrationModel registrationModel;
  
  FertilityModePage(this.registrationModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FertilityModeScreen(registrationModel: registrationModel),
    );
  }
}
