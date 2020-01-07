import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/change_mode_fertility_period/index.dart';
import 'package:wmn_plus/features/registration/index.dart';

class ChangeModeFertilityPeriodPage extends StatelessWidget {
  static const String routeName = '/changeModeFertilityPeriod';
  Fertility fertility;
  ChangeModeFertilityPeriodPage(this.fertility);
  @override
  Widget build(BuildContext context) {
    var _authBloc = BlocProvider.of<AuthBloc>(context);
    var _changeModeFertilityPeriodBloc =
        ChangeModeFertilityPeriodBloc(authBloc: _authBloc);

    return Scaffold(
        appBar: AppBar(),
        body: ChangeModeFertilityPeriodScreen(
            changeModeFertilityPeriodBloc: _changeModeFertilityPeriodBloc,
            fertility: fertility));
  }
}
