import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/profile/change_mode/index.dart';

class ChangeModePage extends StatelessWidget {
  static const String routeName = '/changeMode';

  @override
  Widget build(BuildContext context) {
    var _authBloc = BlocProvider.of<AuthBloc>(context);
    var _changeModeBloc = ChangeModeBloc(authBloc: _authBloc);
    return Scaffold(
      appBar: AppBar(),
      body: ChangeModeScreen(changeModeBloc: _changeModeBloc),
    );
  }
}
