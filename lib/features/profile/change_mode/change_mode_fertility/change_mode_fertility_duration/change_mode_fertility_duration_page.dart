import 'package:flutter/material.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/change_mode_fertility_duration/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

class ChangeModeFertilityDurationPage extends StatelessWidget {
  static const String routeName = '/changeModeFertilityDuration';
  Fertility fertility;
  ChangeModeFertilityDurationPage(this.fertility);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeModeFertilityDurationScreen(fertility: fertility),
    );
  }
}
