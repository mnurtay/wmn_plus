import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_pregnancy/index.dart';

class ChangeModePregnancyPage extends StatelessWidget {
  static const String routeName = '/changeModePregnancy';

  @override
  Widget build(BuildContext context) {
    var _authBloc = BlocProvider.of<AuthBloc>(context);

    var _changeModePregnancyBloc = ChangeModePregnancyBloc(authBloc: _authBloc);

    return Scaffold(
      appBar: AppBar(),
      body: ChangeModePregnancyScreen(
          changeModePregnancyBloc: _changeModePregnancyBloc),
    );
  }
}
