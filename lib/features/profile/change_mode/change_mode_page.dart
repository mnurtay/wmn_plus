import 'package:flutter/material.dart';
import 'package:wmn_plus/features/profile/change_mode/index.dart';

class ChangeModePage extends StatelessWidget {
  static const String routeName = '/changeMode';

  @override
  Widget build(BuildContext context) {
    var _changeModeBloc = ChangeModeBloc();
    return Scaffold(
      appBar: AppBar(
       
      ),
      body: ChangeModeScreen(changeModeBloc: _changeModeBloc),
    );
  }
}
